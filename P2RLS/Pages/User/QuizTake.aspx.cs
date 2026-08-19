using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.BLL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class QuizTake : BasePage
    {
        private int LessonId => Convert.ToInt32(Request.QueryString["lessonId"]);

        private string GetDifficultyLabel(int levelNumber)
        {
            if (levelNumber <= 2) return "Level 1-2 • Foundational";
            if (levelNumber <= 4) return "Level 3-4 • Intermediate";
            return "Level 5-6 • Advanced";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var lesson = LessonDAL.GetById(LessonId);
            if (lesson == null) { Response.Redirect("~/Pages/User/Lessons.aspx"); return; }

            int categoryId = Convert.ToInt32(lesson["category_id"]);
            // Admins bypass the lock restriction and can access any quiz freely.
            if (CurrentRole != "Admin" && !LessonCategoryDAL.IsUnlocked(CurrentUserId, categoryId))
            {
                Response.Redirect("~/Pages/User/Lessons.aspx?locked=1");
                return;
            }

            var category = LessonCategoryDAL.GetById(categoryId);
            int levelNumber = category != null ? Convert.ToInt32(category["level_number"]) : 1;
            litDifficulty.Text = GetDifficultyLabel(levelNumber);

            litLessonTitle.Text = Server.HtmlEncode(lesson["title"].ToString());
            lnkBackToLesson.HRef = ResolveUrl("~/Pages/User/LessonView.aspx?id=" + LessonId);

            var questions = QuizDAL.GetQuestionsForDisplay(LessonId);
            if (questions.Rows.Count == 0)
            {
                pnlQuiz.Visible = false;
                litMessage.Text = "<div class='card p-5 text-center border-0 shadow-sm rounded-4'><div class='fs-1 mb-2'>📝</div><h3 class='h5 text-muted'>No quiz questions available for this lesson yet.</h3></div>";
                return;
            }

            rptQuestions.DataSource = questions;
            rptQuestions.DataBind();
        }

        protected void rptQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var row = (DataRowView)e.Item.DataItem;
            var litOptionsHtml = (Literal)e.Item.FindControl("litOptionsHtml");
            int questionId = Convert.ToInt32(row["id"]);

            var options = new JavaScriptSerializer().Deserialize<List<string>>(row["options"].ToString());
            char[] badges = new char[] { 'A', 'B', 'C', 'D', 'E', 'F' };

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < options.Count; i++)
            {
                char badge = i < badges.Length ? badges[i] : (char)('A' + i);
                string optVal = options[i];

                sb.AppendFormat(@"
                    <label class='quiz-option-card' onclick='selectQuizOption(this)'>
                        <input type='radio' name='q_{0}' value='{1}' class='d-none' />
                        <span class='quiz-option-badge'>{2}</span>
                        <span class='quiz-option-text'>{3}</span>
                    </label>", 
                    questionId, 
                    Server.HtmlEncode(optVal), 
                    badge, 
                    Server.HtmlEncode(optVal));
            }

            litOptionsHtml.Text = sb.ToString();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var answers = new Dictionary<int, string>();

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                var hdnId = (HiddenField)item.FindControl("hdnQuestionId");
                int questionId = Convert.ToInt32(hdnId.Value);

                string selected = Request.Form["q_" + questionId] ?? "";
                answers[questionId] = selected;
            }

            var result = QuizService.SubmitQuiz(CurrentUserId, LessonId, answers);

            Session["VirtualCoins"] = result.NewCoinsBalance;
            Session["LastQuizResult"] = result;
            Response.Redirect("~/Pages/User/QuizResult.aspx");
        }
    }
}