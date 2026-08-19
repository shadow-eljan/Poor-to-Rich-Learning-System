// Location: /App_Code/Models/QuizResultSummary.cs
using System.Collections.Generic;

namespace P2RLS.Models
{
    public class QuizResultSummary
    {
        public int LessonId { get; set; }
        public int TotalQuestions { get; set; }
        public int CorrectCount { get; set; }
        public int ScorePercent { get; set; }
        public int ExpEarned { get; set; }
        public int CoinsEarned { get; set; }
        public int NewLevel { get; set; }
        public int NewCoinsBalance { get; set; }
        public List<string> NewAchievements { get; set; } = new List<string>();
    }
}