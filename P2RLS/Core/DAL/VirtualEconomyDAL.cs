// Location: /App_Code/DAL/VirtualEconomyDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class VirtualEconomyDAL
    {
        public static DataRow GetWalletSummary(int userId)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetWalletSummary", new SqlParameter("@UserId", userId));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        // Returns 1 = success, 0 = insufficient funds
        public static int Deposit(int userId, int amount)
        {
            object result = DbHelper.ExecuteScalar("usp_DepositToSavings",
                new SqlParameter("@UserId", userId), new SqlParameter("@Amount", amount));
            return result != null ? Convert.ToInt32(result) : 0;
        }

        public static int Withdraw(int userId, int amount)
        {
            object result = DbHelper.ExecuteScalar("usp_WithdrawFromSavings",
                new SqlParameter("@UserId", userId), new SqlParameter("@Amount", amount));
            return result != null ? Convert.ToInt32(result) : 0;
        }

        public static int RecordInvestment(int userId, int amount, string assetType, int outcomeAmount)
        {
            object result = DbHelper.ExecuteScalar("usp_RecordInvestment",
                new SqlParameter("@UserId", userId), new SqlParameter("@Amount", amount),
                new SqlParameter("@AssetType", assetType), new SqlParameter("@OutcomeAmount", outcomeAmount));
            return result != null ? Convert.ToInt32(result) : 0;
        }

        public static DataTable GetTransactionHistory(int userId, int limit = 10)
        {
            return DbHelper.ExecuteReader("usp_GetTransactionHistory",
                new SqlParameter("@UserId", userId), new SqlParameter("@Limit", limit));
        }
    }
}