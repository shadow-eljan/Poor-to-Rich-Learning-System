using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class Dashboard : BasePage
    {
        // Chapter/level name mapping (6 fixed levels)
        private static readonly string[] LevelNames =
        {
            "Survival", "Saver", "Borrowing & Credit",
            "Investor", "Wealth Builder", "Financial Freedom"
        };

        private static readonly string[] RankTags =
        {
            "NOVICE", "SQUIRE", "TRADER",
            "STRATEGIST", "TYCOON", "MASTER"
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            LoadDashboard();
        }

        private void LoadDashboard()
        {
            DataRow stats = UserDAL.GetStats(CurrentUserId);
            if (stats == null) return;

            // ── Chapter progress (all 6 levels) ──────────────────────────────
            DataTable catProgress = LessonCategoryDAL.GetForMemberViewWithProgress(CurrentUserId);
            rptProgress.DataSource = catProgress;
            rptProgress.DataBind();

            // Calculate user level & stage dynamically based on completed levels
            int highestCompletedLevel = 0;
            if (catProgress != null)
            {
                foreach (DataRow row in catProgress.Rows)
                {
                    if (row.Table.Columns.Contains("is_completed") && row["is_completed"] != DBNull.Value && Convert.ToInt32(row["is_completed"]) == 1)
                    {
                        int lvl = Convert.ToInt32(row["level_number"]);
                        if (lvl > highestCompletedLevel)
                            highestCompletedLevel = lvl;
                    }
                }
            }

            int userLevel = highestCompletedLevel >= 6 ? 6 : Math.Max(1, highestCompletedLevel + 1);
            int idx = Math.Max(0, Math.Min(userLevel - 1, LevelNames.Length - 1));
            string levelName = LevelNames[idx];
            string rankTag = RankTags[idx];

            // ── Sync all EARNED rank titles into inventory (idempotent, safe every load) ─
            // Any level the user has completed grants its rank title as a free inventory item.
            // Level 1 (Survival) starts as always-unlocked, so grant NOVICE right away.
            // Each higher level is only granted once it's marked is_completed.
            string[] rankDescriptions =
            {
                "Rank: Level 1 Survival",
                "Rank: Level 2 Saver",
                "Rank: Level 3 Borrowing & Credit",
                "Rank: Level 4 Investor",
                "Rank: Level 5 Wealth Builder",
                "Rank: Level 6 Financial Freedom"
            };

            // Always grant NOVICE (Level 1 is always accessible)
            UserDAL.GrantRankTitleIfNotOwned(CurrentUserId, "NOVICE", rankDescriptions[0]);

            // Grant titles for each actually-completed level
            if (catProgress != null)
            {
                foreach (DataRow row in catProgress.Rows)
                {
                    if (row.Table.Columns.Contains("is_completed") && row["is_completed"] != DBNull.Value
                        && Convert.ToInt32(row["is_completed"]) == 1)
                    {
                        int lvl = Convert.ToInt32(row["level_number"]);
                        if (lvl >= 1 && lvl <= 6)
                        {
                            UserDAL.GrantRankTitleIfNotOwned(CurrentUserId, RankTags[lvl - 1], rankDescriptions[lvl - 1]);
                        }
                    }
                }
            }

            // If user has equipped a custom Title reward from the shop, it replaces the default rank tag
            string customTitle = Session["EquippedTitle_" + CurrentUserId] as string;
            if (stats.Table.Columns.Contains("equipped_title") && stats["equipped_title"] != DBNull.Value && !string.IsNullOrWhiteSpace(stats["equipped_title"].ToString()))
            {
                customTitle = stats["equipped_title"].ToString();
            }

            if (!string.IsNullOrWhiteSpace(customTitle))
            {
                rankTag = customTitle.ToUpper();
            }

            string username = stats["username"].ToString();
            int userExp   = Convert.ToInt32(stats["exp"]);

            // ── Hero card ─────────────────────────────────────────────────────
            // Banner
            string bannerUrl = stats.Table.Columns.Contains("banner_url") && stats["banner_url"] != DBNull.Value
                ? stats["banner_url"].ToString() : null;
            if (!string.IsNullOrEmpty(bannerUrl))
                divUserBanner.Style["background-image"] = "url('" + ResolveUrl(bannerUrl) + "')";

            // Avatar
            string avatarUrl = stats.Table.Columns.Contains("avatar_url") && stats["avatar_url"] != DBNull.Value
                ? stats["avatar_url"].ToString() : null;
            if (!string.IsNullOrEmpty(avatarUrl))
            {
                imgUserAvatar.ImageUrl        = ResolveUrl(avatarUrl);
                imgUserAvatar.Visible         = true;
                divUserAvatarFallback.Visible = false;
            }
            else
            {
                imgUserAvatar.Visible         = false;
                divUserAvatarFallback.Visible = true;
            }

            // Border frame
            string borderUrl = stats.Table.Columns.Contains("border_url") && stats["border_url"] != DBNull.Value
                ? stats["border_url"].ToString() : null;
            if (!string.IsNullOrEmpty(borderUrl))
            {
                imgUserAvatarBorder.ImageUrl = ResolveUrl(borderUrl);
                imgUserAvatarBorder.Visible  = true;
            }
            else
            {
                imgUserAvatarBorder.Visible = false;
            }

            // Literals
            litUsername.Text         = Server.HtmlEncode(username);
            litAvatarInitial.Text    = !string.IsNullOrEmpty(username) ? username.Substring(0, 1).ToUpper() : "U";
            litRankTag.Text          = rankTag;
            litCurrentLevelName.Text = Server.HtmlEncode(levelName);
            litLevel.Text            = userLevel.ToString();
            litLevel2.Text           = userLevel.ToString();
            litExp.Text              = string.Format("{0} XP", userExp);
            litCoins.Text            = stats["virtual_coins"].ToString();

            // Pre-fill username in customizer
            txtNewUsername.Text = username;

            // Achievements
            DataRow achSummary = AchievementDAL.GetSummaryForUser(CurrentUserId);
            litAchievementsEarned.Text = achSummary != null
                ? achSummary["Earned"] + "/" + achSummary["Total"]
                : "0/0";

            // ── Inventory ─────────────────────────────────────────────────────
            DataTable inventory = UserDAL.GetInventory(CurrentUserId);
            if (inventory.Rows.Count == 0)
            {
                litNoInventory.Text  = "<p class='text-muted small text-center py-2'>No items purchased yet. <a href='" 
                    + ResolveUrl("~/Pages/User/RewardShop.aspx") 
                    + "' class='text-primary fw-bold'>Visit the Reward Shop &rarr;</a></p>";
                rptInventory.Visible = false;
            }
            else
            {
                litNoInventory.Text     = "";
                rptInventory.Visible    = true;
                rptInventory.DataSource = inventory;
                rptInventory.DataBind();
            }



            // ── Recent Quiz Results (top 3) ───────────────────────────────────
            DataTable results = QuizDAL.GetRecentResults(CurrentUserId, 3);
            litNoResults.Text = results.Rows.Count == 0
                ? "<div class='text-muted small py-3 text-center'>" +
                  "<i class='bi bi-journal-x fs-4 d-block mb-1 text-secondary'></i>" +
                  "No quizzes taken yet &mdash; start a lesson to earn coins.</div>"
                : "";
            rptResults.DataSource = results;
            rptResults.DataBind();

            // ── Recent Simulation Results (top 3) ─────────────────────────────
            DataTable simResults = FinancialSimulationDAL.GetRecentResultsForUser(CurrentUserId, 3);
            litNoSimResults.Text = simResults.Rows.Count == 0
                ? "<div class='text-muted small py-3 text-center'>" +
                  "<i class='bi bi-controller fs-4 d-block mb-1 text-secondary'></i>" +
                  "No simulations tried yet &mdash; test real decisions in the sandbox.</div>"
                : "";
            rptSimResults.DataSource = simResults;
            rptSimResults.DataBind();

            // ── Announcements (top 2) ─────────────────────────────────────────
            DataTable allAnn = AnnouncementDAL.GetForMemberView();
            DataTable topAnn = allAnn.Clone();
            int annCount = Math.Min(allAnn.Rows.Count, 2);
            for (int i = 0; i < annCount; i++)
                topAnn.ImportRow(allAnn.Rows[i]);

            litNoAnnouncements.Text = topAnn.Rows.Count == 0
                ? "<p class='text-muted small mb-0'>No announcements posted yet.</p>"
                : "";
            rptAnnouncements.DataSource = topAnn;
            rptAnnouncements.DataBind();
        }

        // ── Profile Save (Name + Avatar + Banner uploads) ─────────────────────
        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            try
            {
                string newUsername = txtNewUsername.Text.Trim();
                if (string.IsNullOrEmpty(newUsername))
                {
                    litAlert.Text = Alert("danger", "Display name cannot be empty.");
                    LoadDashboard();
                    return;
                }

                // Load current urls so we only update what changed
                DataRow stats = UserDAL.GetStats(CurrentUserId);
                string avatarUrl = stats != null && stats.Table.Columns.Contains("avatar_url") && stats["avatar_url"] != DBNull.Value
                    ? stats["avatar_url"].ToString() : null;
                string bannerUrl = stats != null && stats.Table.Columns.Contains("banner_url") && stats["banner_url"] != DBNull.Value
                    ? stats["banner_url"].ToString() : null;
                string borderUrl = stats != null && stats.Table.Columns.Contains("border_url") && stats["border_url"] != DBNull.Value
                    ? stats["border_url"].ToString() : null;

                if (fuAvatar.HasFile)
                    avatarUrl = SaveUpload(fuAvatar, "~/Uploads/Avatars/");
                if (fuBanner.HasFile)
                    bannerUrl = SaveUpload(fuBanner, "~/Uploads/Banners/");

                UserDAL.UpdateProfile(CurrentUserId, newUsername, avatarUrl, bannerUrl, borderUrl);
                Session["Username"] = newUsername;

                litAlert.Text = Alert("success", "Profile updated successfully!");
                LoadDashboard();
            }
            catch (Exception ex)
            {
                litAlert.Text = Alert("danger", "Error saving profile: " + Server.HtmlEncode(ex.Message));
                LoadDashboard();
            }
        }

        // ── Equip Inventory Item ──────────────────────────────────────────────
        protected void rptInventory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "EquipItem") return;

            try
            {
                string[] parts    = e.CommandArgument.ToString().Split('|');
                string category   = parts.Length > 1 ? parts[1] : "";
                string imageUrl   = parts.Length > 2 ? parts[2] : "";
                string itemName   = parts.Length > 3 ? parts[3] : "";

                DataRow stats = UserDAL.GetStats(CurrentUserId);
                string currentUsername = stats != null ? stats["username"].ToString()
                    : (Session["Username"]?.ToString() ?? "");
                string avatarUrl = stats != null && stats.Table.Columns.Contains("avatar_url") && stats["avatar_url"] != DBNull.Value
                    ? stats["avatar_url"].ToString() : null;
                string bannerUrl = stats != null && stats.Table.Columns.Contains("banner_url") && stats["banner_url"] != DBNull.Value
                    ? stats["banner_url"].ToString() : null;
                string borderUrl = stats != null && stats.Table.Columns.Contains("border_url") && stats["border_url"] != DBNull.Value
                    ? stats["border_url"].ToString() : null;

                switch (category.ToLower())
                {
                    case "avatar":  avatarUrl = imageUrl; break;
                    case "banner":  bannerUrl = imageUrl; break;
                    case "border":  borderUrl = imageUrl; break;
                    case "title":
                        Session["EquippedTitle_" + CurrentUserId] = itemName;
                        break;
                }

                UserDAL.UpdateProfile(CurrentUserId, currentUsername, avatarUrl, bannerUrl, borderUrl);
                litAlert.Text = Alert("success", (category.ToLower() == "title" ? "Title \"" + Server.HtmlEncode(itemName) + "\"" : category) + " equipped successfully!");
                LoadDashboard();

                // Re-open the collapse and keep the inventory tab active after postback
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenInventory",
                    "document.addEventListener('DOMContentLoaded', function() {" +
                    "  var el = document.getElementById('userProfileCollapse');" +
                    "  if (el) { var bs = new bootstrap.Collapse(el, {toggle:false}); bs.show(); }" +
                    "  var tab = document.getElementById('inventory-tab');" +
                    "  if (tab) { var t = new bootstrap.Tab(tab); t.show(); }" +
                    "});", true);
            }
            catch (Exception ex)
            {
                litAlert.Text = Alert("danger", "Error equipping item: " + Server.HtmlEncode(ex.Message));
                LoadDashboard();
            }
        }

        // ── Helpers ───────────────────────────────────────────────────────────
        private string SaveUpload(FileUpload fu, string virtualFolder)
        {
            string folder = Server.MapPath(virtualFolder);
            if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
            string ext      = Path.GetExtension(fu.FileName).ToLower();
            string filename = CurrentUserId + "_" + DateTime.UtcNow.Ticks + ext;
            fu.SaveAs(Path.Combine(folder, filename));
            return virtualFolder.TrimEnd('/') + "/" + filename;
        }

        private string Alert(string type, string message)
        {
            return string.Format(
                "<div class='alert alert-{0} alert-dismissible fade show rounded-4 mb-3' role='alert'>" +
                "{1}<button type='button' class='btn-close' data-bs-dismiss='alert'></button></div>",
                type, Server.HtmlEncode(message));
        }

        public string RenderCosmeticIcon(object categoryObj, object imageUrlObj, object nameObj)
        {
            string category = categoryObj != null ? categoryObj.ToString().Trim().ToLower() : "";
            string imageUrl = imageUrlObj != null && imageUrlObj != DBNull.Value ? imageUrlObj.ToString().Trim() : "";

            if (!string.IsNullOrEmpty(imageUrl))
            {
                string resolvedUrl = ResolveUrl(imageUrl);
                if (category == "border" || category == "frame")
                {
                    return string.Format("<img src='{0}' class='rounded' style='width:38px;height:38px;object-fit:contain;background:#F8FAFC;flex-shrink:0;' alt='frame' />", resolvedUrl);
                }
                else if (category == "avatar")
                {
                    return string.Format("<img src='{0}' class='rounded-circle' style='width:38px;height:38px;object-fit:cover;flex-shrink:0;' alt='avatar' />", resolvedUrl);
                }
                else
                {
                    return string.Format("<img src='{0}' class='rounded' style='width:38px;height:38px;object-fit:cover;flex-shrink:0;' alt='item' />", resolvedUrl);
                }
            }

            switch (category)
            {
                case "title":
                    return "<div class='rounded-3 d-flex align-items-center justify-content-center' style='width:38px;height:38px;background:linear-gradient(135deg,#EDE9FE,#DDD6FE);color:#7C3AED;font-size:1.15rem;flex-shrink:0;'><i class='bi bi-award-fill'></i></div>";
                case "border":
                case "frame":
                    return "<div class='rounded-3 d-flex align-items-center justify-content-center' style='width:38px;height:38px;background:linear-gradient(135deg,#FEF3C7,#FDE68A);color:#D97706;font-size:1.15rem;flex-shrink:0;'><i class='bi bi-bounding-box-circles'></i></div>";
                case "banner":
                    return "<div class='rounded-3 d-flex align-items-center justify-content-center' style='width:38px;height:38px;background:linear-gradient(135deg,#E0F2FE,#BAE6FD);color:#0284C7;font-size:1.15rem;flex-shrink:0;'><i class='bi bi-card-image'></i></div>";
                case "avatar":
                    return "<div class='rounded-circle d-flex align-items-center justify-content-center' style='width:38px;height:38px;background:linear-gradient(135deg,#FCE7F3,#FBCFE8);color:#DB2777;font-size:1.15rem;flex-shrink:0;'><i class='bi bi-person-fill'></i></div>";
                default:
                    return "<div class='rounded-3 d-flex align-items-center justify-content-center' style='width:38px;height:38px;background:#F1F5F9;color:#64748B;font-size:1.15rem;flex-shrink:0;'><i class='bi bi-gift-fill'></i></div>";
            }
        }

        public string RenderCategoryBadge(object categoryObj)
        {
            string cat = categoryObj != null ? categoryObj.ToString().Trim() : "Cosmetic";
            string lower = cat.ToLower();
            if (lower == "title")
                return "<span class='badge bg-primary bg-opacity-10 text-primary' style='font-size:0.65rem;'>🏷️ Title</span>";
            if (lower == "avatar")
                return "<span class='badge bg-info bg-opacity-10 text-info' style='font-size:0.65rem;'>👤 Avatar</span>";
            if (lower == "banner")
                return "<span class='badge bg-success bg-opacity-10 text-success' style='font-size:0.65rem;'>🖼️ Banner</span>";
            if (lower == "border" || lower == "frame")
                return "<span class='badge bg-warning bg-opacity-10 text-warning' style='font-size:0.65rem;'>✨ Frame</span>";
            return string.Format("<span class='badge bg-secondary bg-opacity-10 text-secondary' style='font-size:0.65rem;'>{0}</span>", cat);
        }
    }
}