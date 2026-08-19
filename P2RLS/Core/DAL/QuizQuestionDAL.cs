// Location: /App_Code/DAL/QuizQuestionDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class QuizQuestionDAL
    {
        public static DataTable GetAll(string searchTerm, int? lessonId, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetQuizQuestionsCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@LessonId", (object)lessonId ?? DBNull.Value));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetQuizQuestions",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@LessonId", (object)lessonId ?? DBNull.Value),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static DataRow GetById(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetQuizQuestionByIdAdmin", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static int Insert(int lessonId, string questionText, string optionsJson, string correctAnswer)
        {
            object result = DbHelper.ExecuteScalar("usp_InsertQuizQuestion",
                new SqlParameter("@LessonId", lessonId),
                new SqlParameter("@QuestionText", questionText),
                new SqlParameter("@Options", optionsJson),
                new SqlParameter("@CorrectAnswer", correctAnswer));
            return result != null ? Convert.ToInt32(result) : -1;
        }

        public static void Update(int id, int lessonId, string questionText, string optionsJson, string correctAnswer)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateQuizQuestion",
                new SqlParameter("@Id", id),
                new SqlParameter("@LessonId", lessonId),
                new SqlParameter("@QuestionText", questionText),
                new SqlParameter("@Options", optionsJson),
                new SqlParameter("@CorrectAnswer", correctAnswer));
        }

        public static void Delete(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteQuizQuestion", new SqlParameter("@Id", id));
        }

        public static DataTable GetLessonsForDropdown()
        {
            return DbHelper.ExecuteReader("usp_GetLessonsForDropdown");
        }

        // Bulk-builder support: wipe all questions for a lesson before re-inserting the full set
        public static void DeleteAllForLesson(int lessonId)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteQuestionsForLesson", new SqlParameter("@LessonId", lessonId));
        }

        // Returns all questions for a lesson (for the bulk editor pre-load)
        public static DataTable GetByLesson(int lessonId)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetQuizQuestionsForDisplay", new SqlParameter("@LessonId", lessonId));
            return dt;
        }
    }
}