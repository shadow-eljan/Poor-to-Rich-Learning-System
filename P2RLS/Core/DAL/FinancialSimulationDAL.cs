// Location: /App_Code/DAL/FinancialSimulationDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class FinancialSimulationDAL
    {
        public static DataTable GetAll(string searchTerm, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetFinancialSimulationsCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetFinancialSimulations",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static DataRow GetById(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetFinancialSimulationById", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static int Insert(string title, string description, int levelNumber, string optionsJson)
        {
            object result = DbHelper.ExecuteScalar("usp_InsertFinancialSimulation",
                new SqlParameter("@Title", title), new SqlParameter("@Description", description),
                new SqlParameter("@LevelNumber", levelNumber), new SqlParameter("@Options", optionsJson));
            return result != null ? Convert.ToInt32(result) : -1;
        }

        public static void Update(int id, string title, string description, int levelNumber, string optionsJson)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateFinancialSimulation",
                new SqlParameter("@Id", id), new SqlParameter("@Title", title),
                new SqlParameter("@Description", description), new SqlParameter("@LevelNumber", levelNumber),
                new SqlParameter("@Options", optionsJson));
        }

        public static void Delete(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteFinancialSimulation", new SqlParameter("@Id", id));
        }

        public static DataTable GetAllForMemberView()
        {
            return DbHelper.ExecuteReader("usp_GetAllSimulationsForMemberView");
        }

        public static DataRow GetForTake(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetSimulationForTake", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static void SaveResult(int userId, int simulationId, string decision, string outcome)
        {
            DbHelper.ExecuteNonQuery("usp_SaveSimulationResult",
                new SqlParameter("@UserId", userId), new SqlParameter("@SimulationId", simulationId),
                new SqlParameter("@Decision", decision), new SqlParameter("@Outcome", outcome));
        }

        public static DataTable GetRecentResultsForUser(int userId, int limit = 5)
        {
            return DbHelper.ExecuteReader("usp_GetRecentSimulationResults",
                new SqlParameter("@UserId", userId), new SqlParameter("@Limit", limit));
        }
    }
}