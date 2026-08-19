using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class LessonCategories : AdminBasePage
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
            DataTable dt = LessonCategoryDAL.GetAll(
                txtSearch.Text.Trim(), SortColumn, SortDirection,
                gvCategories.PageIndex + 1, gvCategories.PageSize, out totalRows);

            gvCategories.VirtualItemCount = totalRows;
            gvCategories.DataSource = dt;
            gvCategories.DataBind();

            litEmpty.Text = totalRows == 0 ? "<p class='text-muted'>No categories found.</p>" : "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvCategories.PageIndex = 0;
            BindGrid();
        }

        protected void gvCategories_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCategories.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvCategories_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else
            {
                SortColumn = e.SortExpression;
                SortDirection = "ASC";
            }
            gvCategories.PageIndex = 0;
            BindGrid();
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteCategory") return;

            int id = Convert.ToInt32(e.CommandArgument);
            string warning = null;
            try
            {
                LessonCategoryDAL.Delete(id);
            }
            catch (SqlException)
            {
                // FK violation — lessons still reference this category
                warning = "<div class='alert alert-warning'>Can't delete — this category still has lessons in it.</div>";
            }

            BindGrid();
            if (warning != null) litEmpty.Text = warning;
        }
    }
}