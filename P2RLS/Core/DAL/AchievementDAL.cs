// Location: /App_Code/DAL/AchievementDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class AchievementDAL
    {
        public static DataTable GetAll(string searchTerm, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetAchievementsCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetAchievements",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static DataRow GetById(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetAchievementById", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static int Insert(string name, string description, int rewardCoins, string conditionType, int conditionValue)
        {
            object result = DbHelper.ExecuteScalar("usp_InsertAchievement",
                new SqlParameter("@Name", name), new SqlParameter("@Description", description),
                new SqlParameter("@RewardCoins", rewardCoins), new SqlParameter("@ConditionType", conditionType),
                new SqlParameter("@ConditionValue", conditionValue));
            return result != null ? Convert.ToInt32(result) : -1;
        }

        public static void Update(int id, string name, string description, int rewardCoins, string conditionType, int conditionValue)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateAchievement",
                new SqlParameter("@Id", id), new SqlParameter("@Name", name),
                new SqlParameter("@Description", description), new SqlParameter("@RewardCoins", rewardCoins),
                new SqlParameter("@ConditionType", conditionType), new SqlParameter("@ConditionValue", conditionValue));
        }

        public static void Delete(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteAchievement", new SqlParameter("@Id", id));
        }

        // Returns any achievements newly unlocked by this call (empty table if none)
        public static DataTable CheckAndAward(int userId)
        {
            return DbHelper.ExecuteReader("usp_CheckAndAwardAchievements", new SqlParameter("@UserId", userId));
        }

        public static DataTable GetForMemberView(int userId)
        {
            return DbHelper.ExecuteReader("usp_GetAchievementsForMemberView", new SqlParameter("@UserId", userId));
        }

        public static DataRow GetSummaryForUser(int userId)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetUserAchievementSummary", new SqlParameter("@UserId", userId));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }
    }
}