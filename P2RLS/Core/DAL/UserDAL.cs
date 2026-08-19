// Location: /App_Code/DAL/UserDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;
using P2RLS.Models;

namespace P2RLS.DAL
{
    public static class UserDAL
    {
        // Returns new user id, or -1 if username/email already taken
        public static int InsertUser(string username, string email, string passwordHash, string role = "Member")
        {
            object result = DbHelper.ExecuteScalar("usp_RegisterUser",
                new SqlParameter("@Username", username),
                new SqlParameter("@Email", email),
                new SqlParameter("@PasswordHash", passwordHash),
                new SqlParameter("@Role", role));

            return result != null ? Convert.ToInt32(result) : -1;
        }

        // Returns null if no matching username — caller treats that as invalid login
        public static UserAccount GetUserByUsername(string username)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetUserByUsername",
                new SqlParameter("@Username", username));

            if (dt.Rows.Count == 0) return null;

            DataRow row = dt.Rows[0];
            return new UserAccount
            {
                Id = Convert.ToInt32(row["id"]),
                Username = row["username"].ToString(),
                Email = row["email"].ToString(),
                PasswordHash = row["password_hash"].ToString(),
                Role = row["role"].ToString(),
                Level = Convert.ToInt32(row["level"]),
                Exp = Convert.ToInt32(row["exp"]),
                VirtualCoins = Convert.ToInt32(row["virtual_coins"])
            };
        }
        public static DataRow GetStats(int userId)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetUserStats", new SqlParameter("@UserId", userId));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static DataTable GetAllForAdmin(string searchTerm, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetUsersCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetUsers",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static void UpdateRole(int id, string role)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateUserRole", new SqlParameter("@Id", id), new SqlParameter("@Role", role));
        }

        public static void DeleteUser(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteUser", new SqlParameter("@Id", id));
        }

        // Returns null if user not found; otherwise the updated exp/coins/level row
        public static DataRow AddRewards(int userId, int expDelta, int coinsDelta)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_AddUserRewards",
                new SqlParameter("@UserId", userId),
                new SqlParameter("@ExpDelta", expDelta),
                new SqlParameter("@CoinsDelta", coinsDelta));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static void UpdateProfile(int userId, string username, string avatarUrl = null, string bannerUrl = null, string borderUrl = null)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateUserProfile",
                new SqlParameter("@UserId", userId),
                new SqlParameter("@Username", username),
                new SqlParameter("@AvatarUrl", (object)avatarUrl ?? DBNull.Value),
                new SqlParameter("@BannerUrl", (object)bannerUrl ?? DBNull.Value),
                new SqlParameter("@BorderUrl", (object)borderUrl ?? DBNull.Value));
        }

        public static DataRow GetAdminStats()
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetAdminStats");
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static DataTable GetInventory(int userId)
        {
            return DbHelper.ExecuteReader("usp_GetUserInventory", new SqlParameter("@UserId", userId));
        }

        /// <summary>
        /// Idempotent: grants a rank title (e.g. "NOVICE", "SQUIRE") to the user's inventory.
        /// Creates a cost=0 reward_item if it doesn't exist yet, then adds it to user_inventory.
        /// Safe to call on every Dashboard load — no duplicates are created.
        /// </summary>
        public static void GrantRankTitleIfNotOwned(int userId, string titleName, string description = null)
        {
            DbHelper.ExecuteNonQuery("usp_GrantRankTitleToInventory",
                new SqlParameter("@UserId", userId),
                new SqlParameter("@TitleName", titleName),
                new SqlParameter("@TitleDescription", (object)description ?? DBNull.Value));
        }

        // Returns how many exp points = 1 full level (dynamic: #quiz-enabled lessons * 10)
        public static int GetExpPerLevel()
        {
            object result = DbHelper.ExecuteScalar("usp_GetExpPerLevel");
            int val = result != null ? Convert.ToInt32(result) : 100;
            return val > 0 ? val : 100; // fallback to 100 if no lessons exist yet
        }
    }
}