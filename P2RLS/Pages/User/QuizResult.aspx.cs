using System;
using System.Data;
using P2RLS.DAL;
using P2RLS.Models;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class QuizResult : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var result = Session["LastQuizResult"] as QuizResultSummary;
            if (result == null)
            {
                Response.Redirect("~/Pages/User/Lessons.aspx");
                return;
            }

            int score = result.ScorePercent;
            bool passed = score >= 70;

            litScore.Text = score.ToString();
            litCorrect.Text = result.CorrectCount.ToString();
            litTotal.Text = result.TotalQuestions.ToString();
            litCoins.Text = result.CoinsEarned.ToString();
            litLevel.Text = result.NewLevel.ToString();

            if (passed)
            {
                pnlIcon.Style["background"] = "linear-gradient(135deg, #10B981, #059669)";
                litIcon.Text = "🎉";
                litStatusTitle.Text = "Lesson Mastered!";
                litStatusSubtitle.Text = "Great job! You met the passing criteria (70%+) and earned virtual coins.";
                scoreWrapper.Attributes["class"] = "display-4 fw-extrabold mb-1 text-success";
            }
            else
            {
                pnlIcon.Style["background"] = "linear-gradient(135deg, #F59E0B, #D97706)";
                litIcon.Text = "📝";
                litStatusTitle.Text = "Keep Practicing";
                litStatusSubtitle.Text = "You scored below 70%. Review the material and try again to master this chapter.";
                scoreWrapper.Attributes["class"] = "display-4 fw-extrabold mb-1 text-warning";
                lnkRetake.Visible = true;
                lnkRetake.HRef = ResolveUrl("~/Pages/User/QuizTake.aspx?lessonId=" + result.LessonId);
            }

            // Find Next Lesson in Category
            if (result.LessonId > 0)
            {
                var curLesson = LessonDAL.GetById(result.LessonId);
                if (curLesson != null)
                {
                    int catId = Convert.ToInt32(curLesson["category_id"]);
                    DataTable siblings = LessonDAL.GetByCategory(catId);
                    int curIdx = -1;
                    for (int i = 0; i < siblings.Rows.Count; i++)
                    {
                        if (Convert.ToInt32(siblings.Rows[i]["id"]) == result.LessonId)
                        {
                            curIdx = i;
                            break;
                        }
                    }

                    if (curIdx >= 0 && curIdx < siblings.Rows.Count - 1)
                    {
                        int nextId = Convert.ToInt32(siblings.Rows[curIdx + 1]["id"]);
                        lnkNextLesson.HRef = ResolveUrl("~/Pages/User/LessonView.aspx?id=" + nextId);
                        lnkNextLesson.InnerHtml = "Next Lesson <i class='bi bi-arrow-right ms-1'></i>";
                    }
                    else
                    {
                        // Completed all lessons in this level!
                        lnkNextLesson.HRef = ResolveUrl("~/Pages/User/Lessons.aspx");
                        lnkNextLesson.InnerHtml = "Continue Curriculum <i class='bi bi-arrow-right ms-1'></i>";
                    }
                }
            }

            if (result.NewAchievements.Count > 0)
                litAchievements.Text = "<div class='alert alert-success fw-semibold'>🏆 Achievement unlocked: "
                    + string.Join(", ", result.NewAchievements.ConvertAll(Server.HtmlEncode)) + "</div>";

            Session.Remove("LastQuizResult"); // one-time view; refresh sends back to Lessons
        }
    }
}