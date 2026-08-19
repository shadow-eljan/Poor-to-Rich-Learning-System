// Location: /App_Code/DAL/LessonDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class LessonDAL
    {
        public static DataTable GetAll(string searchTerm, int? categoryId, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetLessonsCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@CategoryId", (object)categoryId ?? DBNull.Value));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetLessons",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@CategoryId", (object)categoryId ?? DBNull.Value),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static DataRow GetById(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetLessonById", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static int Insert(int categoryId, string title, string content, int orderIndex,
            string keyTakeaways = null, string quote = null, string quoteAuthor = null)
        {
            object result = DbHelper.ExecuteScalar("usp_InsertLesson",
                new SqlParameter("@CategoryId", categoryId),
                new SqlParameter("@Title", title),
                new SqlParameter("@Content", content ?? ""),
                new SqlParameter("@OrderIndex", orderIndex),
                new SqlParameter("@KeyTakeaways", (object)keyTakeaways ?? DBNull.Value),
                new SqlParameter("@Quote", (object)quote ?? DBNull.Value),
                new SqlParameter("@QuoteAuthor", (object)quoteAuthor ?? DBNull.Value));
            return result != null ? Convert.ToInt32(result) : -1;
        }

        public static void Update(int id, int categoryId, string title, string content, int orderIndex,
            string keyTakeaways = null, string quote = null, string quoteAuthor = null)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateLesson",
                new SqlParameter("@Id", id),
                new SqlParameter("@CategoryId", categoryId),
                new SqlParameter("@Title", title),
                new SqlParameter("@Content", content ?? ""),
                new SqlParameter("@OrderIndex", orderIndex),
                new SqlParameter("@KeyTakeaways", (object)keyTakeaways ?? DBNull.Value),
                new SqlParameter("@Quote", (object)quote ?? DBNull.Value),
                new SqlParameter("@QuoteAuthor", (object)quoteAuthor ?? DBNull.Value));
        }

        public static void Delete(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteLesson", new SqlParameter("@Id", id));
        }

        public static DataTable GetCategoriesForDropdown()
        {
            return DbHelper.ExecuteReader("usp_GetCategoriesForDropdown");
        }

        public static DataTable GetByCategory(int categoryId)
        {
            return DbHelper.ExecuteReader("usp_GetLessonsByCategory", new SqlParameter("@CategoryId", categoryId));
        }

        public static DataTable GetByCategoryWithProgress(int categoryId, int userId)
        {
            return DbHelper.ExecuteReader("usp_GetLessonsByCategoryWithProgress",
                new SqlParameter("@CategoryId", categoryId),
                new SqlParameter("@UserId", userId));
        }

        public static void CompleteLesson(int userId, int lessonId)
        {
            DbHelper.ExecuteNonQuery("usp_CompleteLesson",
                new SqlParameter("@UserId", userId),
                new SqlParameter("@LessonId", lessonId));
        }
    }
}