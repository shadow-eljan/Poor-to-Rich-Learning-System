using System;
using System.Data;
using System.Text;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class LessonView : BasePage
    {
        protected int CategoryId;
        protected int LessonId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            int id;
            if (!int.TryParse(Request.QueryString["id"], out id))
            {
                Response.Redirect("~/Pages/User/Lessons.aspx");
                return;
            }
            LessonId = id;

            var lesson = LessonDAL.GetById(id);
            if (lesson == null)
            {
                Response.Redirect("~/Pages/User/Lessons.aspx");
                return;
            }

            CategoryId = Convert.ToInt32(lesson["category_id"]);

            // Guard: block direct-URL access to lessons in a locked category
            // Admins bypass this restriction and can view any lesson freely.
            if (CurrentRole != "Admin" && !LessonCategoryDAL.IsUnlocked(CurrentUserId, CategoryId))
            {
                var cat = LessonCategoryDAL.GetById(CategoryId);
                int lockedLevel = cat != null ? Convert.ToInt32(cat["level_number"]) : 2;
                Response.Redirect("~/Pages/User/Lessons.aspx?locked=1&needLevel=" + (lockedLevel - 1));
                return;
            }

            // Category Badge & Title
            string categoryName = lesson.Table.Columns.Contains("category_name") && lesson["category_name"] != DBNull.Value 
                ? lesson["category_name"].ToString() : "Curriculum";
            string levelNum = lesson.Table.Columns.Contains("level_number") && lesson["level_number"] != DBNull.Value 
                ? lesson["level_number"].ToString() : "1";
            
            litCategoryBadge.Text = string.Format("LESSON {0} &bull; {1}", levelNum, Server.HtmlEncode(categoryName.ToUpper()));
            litTitle.Text = Server.HtmlEncode(lesson["title"].ToString());

            // Mark this chapter / sub-lesson as completed by the user (not for admins)
            if (CurrentRole != "Admin")
                LessonDAL.CompleteLesson(CurrentUserId, LessonId);

            // Render Content
            string rawContent = lesson["content"].ToString();
            // If content does not contain HTML tags, convert newlines to <br/>
            if (!rawContent.Contains("<p>") && !rawContent.Contains("<div>") && !rawContent.Contains("<br"))
            {
                litContent.Text = Server.HtmlEncode(rawContent).Replace("\r\n", "<br/><br/>").Replace("\n", "<br/><br/>");
            }
            else
            {
                litContent.Text = rawContent;
            }

            // Key Takeaways formatting
            string rawTakeaways = lesson.Table.Columns.Contains("key_takeaways") && lesson["key_takeaways"] != DBNull.Value
                ? lesson["key_takeaways"].ToString() : "";

            if (string.IsNullOrWhiteSpace(rawTakeaways))
            {
                rawTakeaways = "Core Knowledge: Master the key financial formulas and concepts.\nSmart Strategy: Apply consistent habits for exponential wealth growth.\nZero Risk: Test your comprehension in the end-of-lesson quiz.";
            }

            StringBuilder sbTakeaways = new StringBuilder();
            string[] lines = rawTakeaways.Split(new[] { "\r\n", "\n" }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var line in lines)
            {
                string cleanLine = line.Trim();
                if (string.IsNullOrEmpty(cleanLine)) continue;

                int colonIdx = cleanLine.IndexOf(':');
                if (colonIdx > 0)
                {
                    string kTitle = cleanLine.Substring(0, colonIdx).Trim();
                    string kDesc = cleanLine.Substring(colonIdx + 1).Trim();
                    sbTakeaways.AppendFormat(@"
                        <div class='d-flex align-items-start gap-3 mb-3'>
                            <i class='bi bi-check-circle-fill text-success fs-5 mt-1'></i>
                            <div>
                                <div class='fw-bold text-white small'>{0}</div>
                                <div class='text-white opacity-75 small'>{1}</div>
                            </div>
                        </div>", Server.HtmlEncode(kTitle), Server.HtmlEncode(kDesc));
                }
                else
                {
                    sbTakeaways.AppendFormat(@"
                        <div class='d-flex align-items-start gap-3 mb-3'>
                            <i class='bi bi-check-circle-fill text-success fs-5 mt-1'></i>
                            <div class='text-white opacity-90 small'>{0}</div>
                        </div>", Server.HtmlEncode(cleanLine));
                }
            }
            litTakeaways.Text = sbTakeaways.ToString();

            // Motivational Quote
            string rawQuote = lesson.Table.Columns.Contains("quote") && lesson["quote"] != DBNull.Value
                ? lesson["quote"].ToString() : "";
            string quoteAuthor = lesson.Table.Columns.Contains("quote_author") && lesson["quote_author"] != DBNull.Value
                ? lesson["quote_author"].ToString() : "";

            if (!string.IsNullOrWhiteSpace(rawQuote))
            {
                phQuote.Visible = true;
                litQuoteText.Text = Server.HtmlEncode(rawQuote);
                litQuoteAuthor.Text = !string.IsNullOrWhiteSpace(quoteAuthor) 
                    ? string.Format("&mdash; {0}", Server.HtmlEncode(quoteAuthor))
                    : "";
            }
            else
            {
                phQuote.Visible = false;
            }

            // Previous & Next Lesson Navigation
            DataTable siblingLessons = LessonDAL.GetByCategory(CategoryId);
            int currentIndex = -1;
            for (int i = 0; i < siblingLessons.Rows.Count; i++)
            {
                if (Convert.ToInt32(siblingLessons.Rows[i]["id"]) == LessonId)
                {
                    currentIndex = i;
                    break;
                }
            }

            int totalInCat = Math.Max(siblingLessons.Rows.Count, 1);
            int currentStep = currentIndex >= 0 ? currentIndex + 1 : 1;
            int progressPercent = (currentStep * 100) / totalInCat;
            litProgressPercent.Text = progressPercent + "%";
            progressBar.Style["width"] = progressPercent + "%";

            // Previous Button
            if (currentIndex > 0)
            {
                int prevId = Convert.ToInt32(siblingLessons.Rows[currentIndex - 1]["id"]);
                lnkPrev.HRef = ResolveUrl("~/Pages/User/LessonView.aspx?id=" + prevId);
                lnkPrev.Visible = true;
            }
            else
            {
                lnkPrev.HRef = ResolveUrl("~/Pages/User/LessonList.aspx?categoryId=" + CategoryId);
                lnkPrev.Visible = true;
            }

            // Next Lesson teaser (without time)
            if (currentIndex >= 0 && currentIndex < siblingLessons.Rows.Count - 1)
            {
                phNextLesson.Visible = true;
                litNextLessonTitle.Text = Server.HtmlEncode(siblingLessons.Rows[currentIndex + 1]["title"].ToString());
            }
            else
            {
                phNextLesson.Visible = true;
                litNextLessonTitle.Text = "Comprehensive Level Quiz & Review";
            }

            // Take Quiz Link
            lnkTakeQuiz.HRef = ResolveUrl("~/Pages/User/QuizTake.aspx?lessonId=" + LessonId);
            lnkBackToList.HRef = ResolveUrl("~/Pages/User/LessonList.aspx?categoryId=" + CategoryId);
        }
    }
}
