using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class FinancialSimulations : AdminBasePage
    {
        private string SortColumn
        {
            get => ViewState["SortColumn"] as string ?? "title";
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
            DataTable dt = FinancialSimulationDAL.GetAll(txtSearch.Text.Trim(), SortColumn, SortDirection,
                gvSimulations.PageIndex + 1, gvSimulations.PageSize, out totalRows);

            gvSimulations.VirtualItemCount = totalRows;
            gvSimulations.DataSource = dt;
            gvSimulations.DataBind();
            litEmpty.Text = totalRows == 0 ? "<p class='text-muted'>No simulations found.</p>" : "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvSimulations.PageIndex = 0;
            BindGrid();
        }

        protected void gvSimulations_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSimulations.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvSimulations_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else { SortColumn = e.SortExpression; SortDirection = "ASC"; }
            gvSimulations.PageIndex = 0;
            BindGrid();
        }

        protected void gvSimulations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteSimulation") return;
            int id = Convert.ToInt32(e.CommandArgument);
            string warning = null;
            try { FinancialSimulationDAL.Delete(id); }
            catch (SqlException)
            {
                warning = "<div class='alert alert-warning'>Can't delete — results are already recorded for this simulation.</div>";
            }
            BindGrid();
            if (warning != null) litEmpty.Text = warning;
        }
    }
}