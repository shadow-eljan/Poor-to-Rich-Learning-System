using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class RewardItems : AdminBasePage
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
            DataTable dt = RewardItemDAL.GetAll(txtSearch.Text.Trim(), SortColumn, SortDirection,
                gvItems.PageIndex + 1, gvItems.PageSize, out totalRows);

            gvItems.VirtualItemCount = totalRows;
            gvItems.DataSource = dt;
            gvItems.DataBind();
            litEmpty.Text = totalRows == 0 ? "<p class='text-muted'>No reward items found.</p>" : "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvItems.PageIndex = 0;
            BindGrid();
        }

        protected void gvItems_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvItems.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvItems_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else { SortColumn = e.SortExpression; SortDirection = "ASC"; }
            gvItems.PageIndex = 0;
            BindGrid();
        }

        protected void gvItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteItem") return;
            int id = Convert.ToInt32(e.CommandArgument);
            string warning = null;
            try { RewardItemDAL.Delete(id); }
            catch (SqlException)
            {
                warning = "<div class='alert alert-warning'>Can't delete — someone already owns this item.</div>";
            }
            BindGrid();
            if (warning != null) litEmpty.Text = warning;
        }
    }
}