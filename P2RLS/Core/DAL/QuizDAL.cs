// Location: /App_Code/DAL/QuizDAL.cs
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class QuizDAL
    {
        public static DataTable GetQuestionsForDisplay(int lessonId)
        {
            return DbHelper.ExecuteReader("usp_GetQuizQuestionsForDisplay", new SqlParameter("@LessonId", lessonId));
        }

        public static Dictionary<int, string> GetAnswers(int lessonId)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetQuizAnswers", new SqlParameter("@LessonId", lessonId));
            var answers = new Dictionary<int, string>();
            foreach (DataRow row in dt.Rows)
                answers[Convert.ToInt32(row["id"])] = row["correct_answer"].ToString();
            return answers;
        }

        public static void SaveResult(int userId, int lessonId, int score)
        {
            DbHelper.ExecuteNonQuery("usp_SaveQuizResult",
                new SqlParameter("@UserId", userId),
                new SqlParameter("@LessonId", lessonId),
                new SqlParameter("@Score", score));
        }

        public static DataTable GetRecentResults(int userId, int limit = 5)
        {
            return DbHelper.ExecuteReader("usp_GetRecentQuizResults",
                new SqlParameter("@UserId", userId),
                new SqlParameter("@Limit", limit));
        }

        public static int GetTotalQuizzesTaken(int userId)
        {
            object result = DbHelper.ExecuteScalar("usp_GetQuizResultsCount", new SqlParameter("@UserId", userId));
            return result != null ? Convert.ToInt32(result) : 0;
        }
    }
}