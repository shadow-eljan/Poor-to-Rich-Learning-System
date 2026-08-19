// Location: /App_Code/DAL/AnnouncementDAL.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace P2RLS.DAL
{
    public static class AnnouncementDAL
    {
        public static DataTable GetAll(string searchTerm, string sortColumn, string sortDirection,
            int pageNumber, int pageSize, out int totalRows)
        {
            object countResult = DbHelper.ExecuteScalar("usp_GetAnnouncementsCount",
                new SqlParameter("@SearchTerm", searchTerm ?? ""));
            totalRows = countResult != null ? Convert.ToInt32(countResult) : 0;

            return DbHelper.ExecuteReader("usp_GetAnnouncements",
                new SqlParameter("@SearchTerm", searchTerm ?? ""),
                new SqlParameter("@SortColumn", sortColumn),
                new SqlParameter("@SortDirection", sortDirection),
                new SqlParameter("@PageNumber", pageNumber),
                new SqlParameter("@PageSize", pageSize));
        }

        public static DataRow GetById(int id)
        {
            DataTable dt = DbHelper.ExecuteReader("usp_GetAnnouncementById", new SqlParameter("@Id", id));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static int Insert(string title, string content, int postedBy)
        {
            object result = DbHelper.ExecuteScalar("usp_InsertAnnouncement",
                new SqlParameter("@Title", title), new SqlParameter("@Content", content),
                new SqlParameter("@PostedBy", postedBy));
            return result != null ? Convert.ToInt32(result) : -1;
        }

        public static void Update(int id, string title, string content)
        {
            DbHelper.ExecuteNonQuery("usp_UpdateAnnouncement",
                new SqlParameter("@Id", id), new SqlParameter("@Title", title),
                new SqlParameter("@Content", content));
        }

        public static void Delete(int id)
        {
            DbHelper.ExecuteNonQuery("usp_DeleteAnnouncement", new SqlParameter("@Id", id));
        }

        public static DataTable GetForMemberView()
        {
            return DbHelper.ExecuteReader("usp_GetAnnouncementsForMemberView");
        }
    }
}