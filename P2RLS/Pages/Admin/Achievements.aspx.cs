using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class Achievements : AdminBasePage
    {
        private string SortColumn
        {
            get => ViewState["SortColumn"] as string ?? "name";
            set => ViewState["SortColumn"] = value;
        }
        private string SortDirection
        {
            get => ViewState["SortDirection"] as string ?? "ASC";
            set => ViewState["SortDirection"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            int totalRows;
            DataTable dt = AchievementDAL.GetAll(txtSearch.Text.Trim(), SortColumn, SortDirection,
                gvAchievements.PageIndex + 1, gvAchievements.PageSize, out totalRows);

            gvAchievements.VirtualItemCount = totalRows;
            gvAchievements.DataSource = dt;
            gvAchievements.DataBind();
            litEmpty.Text = totalRows == 0 ? "<p class='text-muted'>No achievements found.</p>" : "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvAchievements.PageIndex = 0;
            BindGrid();
        }

        protected void gvAchievements_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAchievements.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvAchievements_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else { SortColumn = e.SortExpression; SortDirection = "ASC"; }
            gvAchievements.PageIndex = 0;
            BindGrid();
        }

        protected void gvAchievements_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteAchievement") return;
            int id = Convert.ToInt32(e.CommandArgument);
            string warning = null;
            try { AchievementDAL.Delete(id); }
            catch (SqlException)
            {
                warning = "<div class='alert alert-warning'>Can't delete — some users have already earned it.</div>";
            }
            BindGrid();
            if (warning != null) litEmpty.Text = warning;
        }
    }
}