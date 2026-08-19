using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class Lessons : AdminBasePage
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
            if (!IsPostBack)
            {
                BindCategoryFilter();
                BindGrid();
            }
        }

        private void BindCategoryFilter()
        {
            var categories = LessonDAL.GetCategoriesForDropdown();
            ddlCategoryFilter.DataSource = categories;
            ddlCategoryFilter.DataTextField = "name";
            ddlCategoryFilter.DataValueField = "id";
            ddlCategoryFilter.DataBind();
            ddlCategoryFilter.Items.Insert(0, new ListItem("All Categories", ""));
        }

        private void BindGrid()
        {
            int? categoryId = string.IsNullOrEmpty(ddlCategoryFilter.SelectedValue)
                ? (int?)null : Convert.ToInt32(ddlCategoryFilter.SelectedValue);

            int totalRows;
            DataTable dt = LessonDAL.GetAll(txtSearch.Text.Trim(), categoryId, SortColumn, SortDirection,
                gvLessons.PageIndex + 1, gvLessons.PageSize, out totalRows);

            gvLessons.VirtualItemCount = totalRows;
            gvLessons.DataSource = dt;
            gvLessons.DataBind();
            litEmpty.Text = totalRows == 0 ? "<p class='text-muted'>No lessons found.</p>" : "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvLessons.PageIndex = 0;
            BindGrid();
        }

        protected void gvLessons_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLessons.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvLessons_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else { SortColumn = e.SortExpression; SortDirection = "ASC"; }
            gvLessons.PageIndex = 0;
            BindGrid();
        }

        protected void gvLessons_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteLesson") return;
            int id = Convert.ToInt32(e.CommandArgument);
            string warning = null;
            try { LessonDAL.Delete(id); }
            catch (SqlException)
            {
                warning = "<div class='alert alert-warning'>Can't delete — this lesson still has quiz data linked to it.</div>";
            }
            BindGrid();
            if (warning != null) litEmpty.Text = warning;
        }
    }
}