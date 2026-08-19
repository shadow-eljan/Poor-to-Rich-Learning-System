// Location: /App_Code/BLL/QuizService.cs
using System;
using System.Collections.Generic;
using System.Data;
using P2RLS.DAL;
using P2RLS.Models;

namespace P2RLS.BLL
{
    public static class QuizService
    {
        public static QuizResultSummary SubmitQuiz(int userId, int lessonId, Dictionary<int, string> submittedAnswers)
        {
            var correctAnswers = QuizDAL.GetAnswers(lessonId);
            int correctCount = 0;

            foreach (var kvp in correctAnswers)
            {
                if (submittedAnswers.TryGetValue(kvp.Key, out string given) && given == kvp.Value)
                    correctCount++;
            }

            int total = correctAnswers.Count;
            int scorePercent = total == 0 ? 0 : (int)Math.Round(100.0 * correctCount / total);
            int expEarned = 0; // Quizzes give no level EXP; EXP is earned via chapter completion
            int coinsEarned = scorePercent >= 70 ? 50 : 20; // pass threshold reward

            QuizDAL.SaveResult(userId, lessonId, scorePercent);
            LessonDAL.CompleteLesson(userId, lessonId);
            UserDAL.AddRewards(userId, expEarned, coinsEarned);

            var newAchievements = new List<string>();
            DataTable unlocked = AchievementDAL.CheckAndAward(userId);
            foreach (DataRow row in unlocked.Rows) newAchievements.Add(row["name"].ToString());

            // Re-fetch rather than trust the AddRewards row — achievements may have added more coins after it
            DataRow finalStats = UserDAL.GetStats(userId);

            return new QuizResultSummary
            {
                LessonId = lessonId,
                TotalQuestions = total,
                CorrectCount = correctCount,
                ScorePercent = scorePercent,
                ExpEarned = expEarned,
                CoinsEarned = coinsEarned,
                NewLevel = finalStats != null ? Convert.ToInt32(finalStats["level"]) : 1,
                NewCoinsBalance = finalStats != null ? Convert.ToInt32(finalStats["virtual_coins"]) : 0,
                NewAchievements = newAchievements
            };
        }
    }
}