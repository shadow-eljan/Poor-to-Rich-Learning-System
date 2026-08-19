using System;
using System.Data;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class QuizQuestions : AdminBasePage
    {
        private string SortColumn
        {
            get => ViewState["SortColumn"] as string ?? "question_text";
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
                BindLessonFilter();
                BindGrid();
            }
        }

        private void BindLessonFilter()
        {
            var lessons = QuizQuestionDAL.GetLessonsForDropdown();
            ddlLessonFilter.DataSource = lessons;
            ddlLessonFilter.DataTextField = "title";
            ddlLessonFilter.DataValueField = "id";
            ddlLessonFilter.DataBind();
            ddlLessonFilter.Items.Insert(0, new ListItem("All Lessons", ""));
        }

        private void BindGrid()
        {
            int? lessonId = string.IsNullOrEmpty(ddlLessonFilter.SelectedValue)
                ? (int?)null : Convert.ToInt32(ddlLessonFilter.SelectedValue);

            int totalRows;
            DataTable dt = QuizQuestionDAL.GetAll(txtSearch.Text.Trim(), lessonId, SortColumn, SortDirection,
                gvQuestions.PageIndex + 1, gvQuestions.PageSize, out totalRows);

            gvQuestions.VirtualItemCount = totalRows;
            gvQuestions.DataSource = dt;
            gvQuestions.DataBind();
            litEmpty.Text = totalRows == 0 ? "<p class='text-muted'>No questions found.</p>" : "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvQuestions.PageIndex = 0;
            BindGrid();
        }

        protected void gvQuestions_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvQuestions.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvQuestions_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else { SortColumn = e.SortExpression; SortDirection = "ASC"; }
            gvQuestions.PageIndex = 0;
            BindGrid();
        }

        protected void gvQuestions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteQuestion") return;
            QuizQuestionDAL.Delete(Convert.ToInt32(e.CommandArgument));
            BindGrid();
        }
    }
}