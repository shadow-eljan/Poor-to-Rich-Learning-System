using System;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class LessonList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            int categoryId;
            if (!int.TryParse(Request.QueryString["categoryId"], out categoryId))
            {
                Response.Redirect("~/Pages/User/Lessons.aspx");
                return;
            }

            var category = LessonCategoryDAL.GetById(categoryId);
            if (category == null)
            {
                Response.Redirect("~/Pages/User/Lessons.aspx");
                return;
            }

            // Guard: block access to locked categories (must pass all quizzes in prior level)
            // Admins bypass this restriction and can view any level freely.
            if (CurrentRole != "Admin" && !LessonCategoryDAL.IsUnlocked(CurrentUserId, categoryId))
            {
                int lockedLevel = Convert.ToInt32(category["level_number"]);
                Response.Redirect("~/Pages/User/Lessons.aspx?locked=1&needLevel=" + (lockedLevel - 1));
                return;
            }

            litCategoryName.Text = Server.HtmlEncode(category["name"].ToString());
            litCategoryDesc.Text = Server.HtmlEncode(category["description"].ToString());

            rptLessons.DataSource = LessonDAL.GetByCategoryWithProgress(categoryId, CurrentUserId);
            rptLessons.DataBind();
        }
    }
}