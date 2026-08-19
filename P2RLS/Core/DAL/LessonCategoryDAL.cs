// Location: /App_Code/DAL/LessonCategoryDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class LessonCategoryDAL
    {
        public static DataTable GetAll(string searchTerm, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetLessonCategoriesCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetLessonCategories",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static void Delete(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteLessonCategory", new SqlParameter("@Id", id));
        }

        public static DataRow GetById(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetLessonCategoryById", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static DataTable GetAllForMemberView()
        {
            return DbHelper.ExecuteReader("usp_GetAllCategories");
        }

        // Used by the Lessons browse page — includes is_unlocked/is_completed per category
        public static DataTable GetForMemberViewWithProgress(int userId)
        {
            return DbHelper.ExecuteReader("usp_GetCategoriesWithUnlockStatus", new SqlParameter("@UserId", userId));
        }

        // Used to guard direct URL access to a lesson/quiz page in a locked category
        public static bool IsUnlocked(int userId, int categoryId)
        {
            object result = DbHelper.ExecuteScalar("usp_IsCategoryUnlocked",
                new SqlParameter("@UserId", userId), new SqlParameter("@CategoryId", categoryId));
            return result != null && Convert.ToInt32(result) == 1;
        }

        public static int Insert(string name, int levelNumber, string description, string estimatedTime = null, string imageUrl = null)
        {
            object result = DbHelper.ExecuteScalar("usp_InsertLessonCategory",
                new SqlParameter("@Name", name),
                new SqlParameter("@LevelNumber", levelNumber),
                new SqlParameter("@Description", (object)description ?? DBNull.Value),
                new SqlParameter("@EstimatedTime", (object)estimatedTime ?? DBNull.Value),
                new SqlParameter("@ImageUrl", (object)imageUrl ?? DBNull.Value));
            return result != null ? Convert.ToInt32(result) : -1;
        }

        public static void Update(int id, string name, int levelNumber, string description, string estimatedTime = null, string imageUrl = null)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateLessonCategory",
                new SqlParameter("@Id", id),
                new SqlParameter("@Name", name),
                new SqlParameter("@LevelNumber", levelNumber),
                new SqlParameter("@Description", (object)description ?? DBNull.Value),
                new SqlParameter("@EstimatedTime", (object)estimatedTime ?? DBNull.Value),
                new SqlParameter("@ImageUrl", (object)imageUrl ?? DBNull.Value));
        }
    }
}