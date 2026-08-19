using System;
using System.Data;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class Lessons : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Show a notification if the user was redirected here from a locked category
                if (Request.QueryString["locked"] == "1")
                {
                    int needLevel;
                    string levelPart = int.TryParse(Request.QueryString["needLevel"], out needLevel) && needLevel > 0
                        ? string.Format(" You need to complete <strong>Level {0}</strong> first.", needLevel)
                        : " Complete all quizzes in the previous level first.";

                    litLockedMsg.Text = string.Format(
                        "<div class=\"alert alert-warning alert-dismissible fade show d-flex align-items-center gap-2 mb-4\" role=\"alert\">" +
                        "<span style=\"font-size:1.3rem\">&#128274;</span>" +
                        "<div><strong>Level locked.</strong>{0}</div>" +
                        "<button type=\"button\" class=\"btn-close ms-auto\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" +
                        "</div>",
                        levelPart);
                }

                var categories = LessonCategoryDAL.GetForMemberViewWithProgress(CurrentUserId);

                // Admins see all levels as unlocked so no cards appear locked
                if (CurrentRole == "Admin" && categories.Columns.Contains("is_unlocked"))
                {
                    foreach (DataRow r in categories.Rows)
                        r["is_unlocked"] = 1;
                }

                rptCategories.DataSource = categories;
                rptCategories.DataBind();
            }
        }

        protected string GetCategoryBannerHtml(object imageUrlObj, object levelNumObj)
        {
            string imgUrl = imageUrlObj != null && imageUrlObj != DBNull.Value ? imageUrlObj.ToString() : "";
            int levelNum = levelNumObj != null && levelNumObj != DBNull.Value ? Convert.ToInt32(levelNumObj) : 1;

            if (!string.IsNullOrWhiteSpace(imgUrl))
            {
                return string.Format("<img src='{0}' alt='Level {1}' class='w-100 h-100' style='object-fit:cover;' />", 
                    ResolveUrl(imgUrl), levelNum);
            }

            // Fallback rich illustrations with themes matching each stage
            string[] gradients = {
                "linear-gradient(135deg, #7C3AED 0%, #3B82F6 100%)",      // Lvl 1: Survival
                "linear-gradient(135deg, #0284C7 0%, #0EA5E9 100%)",      // Lvl 2: Saver
                "linear-gradient(135deg, #1E1B4B 0%, #312E81 100%)",      // Lvl 3: Credit
                "linear-gradient(135deg, #047857 0%, #10B981 100%)",      // Lvl 4: Investor
                "linear-gradient(135deg, #B45309 0%, #F59E0B 100%)",      // Lvl 5: Wealth Builder
                "linear-gradient(135deg, #C026D3 0%, #7C3AED 100%)"       // Lvl 6: Freedom
            };

            string[] icons = {
                "bi-graph-up-arrow",
                "bi-bank2",
                "bi-credit-card-2-front-fill",
                "bi-tree-fill",
                "bi-diagram-3-fill",
                "bi-stars"
            };

            int idx = Math.Max(0, Math.Min(levelNum - 1, gradients.Length - 1));
            return string.Format(
                "<div class='w-100 h-100 d-flex align-items-center justify-content-center text-white' style='background:{0};'>" +
                "<i class='bi {1}' style='font-size: 3rem; opacity: 0.85;'></i>" +
                "</div>", gradients[idx], icons[idx]);
        }

        protected int ComputePercent(object totalObj, object completedObj)
        {
            int total = totalObj != null && totalObj != DBNull.Value ? Convert.ToInt32(totalObj) : 0;
            int completed = completedObj != null && completedObj != DBNull.Value ? Convert.ToInt32(completedObj) : 0;
            if (total <= 0) return 0;
            return Math.Min(100, (completed * 100) / total);
        }
    }
}