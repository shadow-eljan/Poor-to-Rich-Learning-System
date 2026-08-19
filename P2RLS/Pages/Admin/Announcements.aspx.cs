using System;
using System.Data;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class Announcements : AdminBasePage
    {
        private string SortColumn
        {
            get => ViewState["SortColumn"] as string ?? "posted_at";
            set => ViewState["SortColumn"] = value;
        }
        private string SortDirection
        {
            get => ViewState["SortDirection"] as string ?? "DESC";
            set => ViewState["SortDirection"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            int totalRows;
            DataTable dt = AnnouncementDAL.GetAll(txtSearch.Text.Trim(), SortColumn, SortDirection,
                gvAnnouncements.PageIndex + 1, gvAnnouncements.PageSize, out totalRows);

            gvAnnouncements.VirtualItemCount = totalRows;
            gvAnnouncements.DataSource = dt;
            gvAnnouncements.DataBind();
            litEmpty.Text = totalRows == 0 ? "<p class='text-muted'>No announcements found.</p>" : "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvAnnouncements.PageIndex = 0;
            BindGrid();
        }

        protected void gvAnnouncements_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAnnouncements.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvAnnouncements_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else { SortColumn = e.SortExpression; SortDirection = "ASC"; }
            gvAnnouncements.PageIndex = 0;
            BindGrid();
        }

        protected void gvAnnouncements_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteAnnouncement") return;
            AnnouncementDAL.Delete(Convert.ToInt32(e.CommandArgument));
            BindGrid();
        }
    }
}