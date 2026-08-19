// Location: /App_Code/DAL/RewardItemDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class RewardItemDAL
    {
        public static DataTable GetAll(string searchTerm, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetRewardItemsCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetRewardItems",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static DataRow GetById(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetRewardItemById", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static int Insert(string name, string category, int cost, string type, string imageUrl = null)
        {
            object result = DbHelper.ExecuteScalar("usp_InsertRewardItem",
                new SqlParameter("@Name", name), new SqlParameter("@Category", category),
                new SqlParameter("@Cost", cost), new SqlParameter("@Type", (object)type ?? DBNull.Value),
                new SqlParameter("@ImageUrl", (object)imageUrl ?? DBNull.Value));
            return result != null ? Convert.ToInt32(result) : -1;
        }

        public static void Update(int id, string name, string category, int cost, string type, string imageUrl = null)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateRewardItem",
                new SqlParameter("@Id", id), new SqlParameter("@Name", name),
                new SqlParameter("@Category", category), new SqlParameter("@Cost", cost),
                new SqlParameter("@Type", (object)type ?? DBNull.Value),
                new SqlParameter("@ImageUrl", (object)imageUrl ?? DBNull.Value));
        }

        public static void Delete(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteRewardItem", new SqlParameter("@Id", id));
        }

        public static DataTable GetForShop(int userId)
        {
            return DbHelper.ExecuteReader("usp_GetRewardItemsForShop", new SqlParameter("@UserId", userId));
        }

        // Returns raw result code — see usp_PurchaseRewardItem comment for meaning
        public static int Purchase(int userId, int itemId)
        {
            object result = DbHelper.ExecuteScalar("usp_PurchaseRewardItem",
                new SqlParameter("@UserId", userId), new SqlParameter("@ItemId", itemId));
            return result != null ? Convert.ToInt32(result) : -2;
        }
    }
}