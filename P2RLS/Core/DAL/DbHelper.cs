// Location: /App_Code/DAL/DbHelper.cs
// Every query goes through a stored procedure + parameters — never string-concatenated SQL.
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace P2RLS.DAL
{
    public static class DbHelper
    {
        private static readonly string ConnStr =
            ConfigurationManager.ConnectionStrings["P2RLSConnection"].ConnectionString;

        // For SELECTs returning rows
        public static DataTable ExecuteReader(string spName, params SqlParameter[] parameters)
        {
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(spName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null) cmd.Parameters.AddRange(parameters);

                conn.Open();
                var dt = new DataTable();
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
                return dt;
            }
        }

        // For single-value results (COUNT, EXISTS, a single ID, etc.)
        public static object ExecuteScalar(string spName, params SqlParameter[] parameters)
        {
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(spName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null) cmd.Parameters.AddRange(parameters);

                conn.Open();
                return cmd.ExecuteScalar();
            }
        }

        // For INSERT/UPDATE/DELETE — returns rows affected
        public static int ExecuteNonQuery(string spName, params SqlParameter[] parameters)
        {
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(spName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null) cmd.Parameters.AddRange(parameters);

                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
    }
}