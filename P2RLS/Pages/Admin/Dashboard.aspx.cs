using System;
using System.Data;
using System.IO;
using System.Web.UI;
using P2RLS.Common;
using P2RLS.DAL;

namespace P2RLS.Pages.Admin
{
    public partial class Dashboard : AdminBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAdminProfile();
                LoadInventory();
                LoadKPIStats();
                LoadRecentUsers();
            }
        }

        private void LoadAdminProfile()
        {
            DataRow userStats = UserDAL.GetStats(CurrentUserId);
            if (userStats != null)
            {
                string uname = userStats["username"] != null ? userStats["username"].ToString() : "Admin";
                litUsername.Text = Server.HtmlEncode(uname);
                txtNewUsername.Text = uname;

                litEmail.Text = userStats["email"] != null ? Server.HtmlEncode(userStats["email"].ToString()) : "";

                // Avatar
                if (userStats["avatar_url"] != DBNull.Value && !string.IsNullOrEmpty(userStats["avatar_url"].ToString()))
                {
                    imgAvatar.ImageUrl = ResolveUrl(userStats["avatar_url"].ToString());
                    imgAvatar.Visible = true;
                    divAvatarFallback.Visible = false;
                }
                else
                {
                    imgAvatar.Visible = false;
                    divAvatarFallback.Visible = true;
                    litAvatarInitial.Text = uname.Length > 0 ? uname.Substring(0, 1).ToUpper() : "A";
                }

                // Banner
                if (userStats["banner_url"] != DBNull.Value && !string.IsNullOrEmpty(userStats["banner_url"].ToString()))
                {
                    divBanner.Style["background-image"] = string.Format("url('{0}')", ResolveUrl(userStats["banner_url"].ToString()));
                }

                // Border
                if (userStats["border_url"] != DBNull.Value && !string.IsNullOrEmpty(userStats["border_url"].ToString()))
                {
                    imgAvatarBorder.ImageUrl = ResolveUrl(userStats["border_url"].ToString());
                    imgAvatarBorder.Visible = true;
                }
            }
        }

        private void LoadInventory()
        {
            DataTable inventory = UserDAL.GetInventory(CurrentUserId);
            if (inventory.Rows.Count == 0)
            {
                litNoInventory.Text  = "<p class='text-muted small text-center py-2'>No items purchased yet. <a href='" + ResolveUrl("~/Pages/User/RewardShop.aspx") + "' class='text-primary fw-bold'>Visit the Reward Shop &rarr;</a></p>";
                rptInventory.Visible = false;
            }
            else
            {
                litNoInventory.Text     = "";
                rptInventory.Visible    = true;
                rptInventory.DataSource = inventory;
                rptInventory.DataBind();
            }
        }

        protected void rptInventory_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "EquipItem") return;
            try
            {
                string[] parts    = e.CommandArgument.ToString().Split('|');
                string category   = parts.Length > 1 ? parts[1] : "";
                string imageUrl   = parts.Length > 2 ? parts[2] : "";
                string itemName   = parts.Length > 3 ? parts[3] : "";

                DataRow stats = UserDAL.GetStats(CurrentUserId);
                string currentUsername = stats != null ? stats["username"].ToString() : (Session["Username"]?.ToString() ?? "");
                string avatarUrl = stats != null && stats["avatar_url"] != DBNull.Value ? stats["avatar_url"].ToString() : null;
                string bannerUrl = stats != null && stats["banner_url"] != DBNull.Value ? stats["banner_url"].ToString() : null;
                string borderUrl = stats != null && stats["border_url"] != DBNull.Value ? stats["border_url"].ToString() : null;

                switch (category.ToLower())
                {
                    case "avatar": avatarUrl = imageUrl; break;
                    case "banner": bannerUrl = imageUrl; break;
                    case "border": borderUrl = imageUrl; break;
                    case "title":
                        Session["EquippedTitle_" + CurrentUserId] = itemName;
                        break;
                }

                UserDAL.UpdateProfile(CurrentUserId, currentUsername, avatarUrl, bannerUrl, borderUrl);
                litAlert.Text = "<div class='alert alert-success rounded-4'>" + (category.ToLower() == "title" ? "Title \"" + Server.HtmlEncode(itemName) + "\"" : Server.HtmlEncode(category)) + " equipped successfully!</div>";
                LoadAdminProfile();
                LoadInventory();

                // Re-open the collapse and keep the inventory tab active after postback
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenInventory",
                    "document.addEventListener('DOMContentLoaded', function() {" +
                    "  var el = document.getElementById('adminProfileCollapse');" +
                    "  if (el) { var bs = new bootstrap.Collapse(el, {toggle:false}); bs.show(); }" +
                    "  var tab = document.getElementById('admin-inventory-tab');" +
                    "  if (tab) { var t = new bootstrap.Tab(tab); t.show(); }" +
                    "});", true);
            }
            catch (Exception ex)
            {
                litAlert.Text = "<div class='alert alert-danger rounded-4'>Error: " + Server.HtmlEncode(ex.Message) + "</div>";
            }
        }

        private void LoadKPIStats()
        {
            DataRow stats = UserDAL.GetAdminStats();
            if (stats != null)
            {
                litTotalUsers.Text = stats["TotalUsers"].ToString();
                litActiveUsers.Text = stats["ActiveUsers"].ToString();
                litTotalLessons.Text = string.Format("{0}", stats["TotalLessons"]);
                litTotalQuizzes.Text = stats["TotalQuizzes"].ToString();
                litTotalSimulations.Text = stats["TotalSimulations"].ToString();
                litTotalCoinsEconomy.Text = string.Format("{0:N0}", stats["TotalCoinsEconomy"]);
            }
        }

        private void LoadRecentUsers()
        {
            int total;
            DataTable dt = UserDAL.GetAllForAdmin("", "created_at", "DESC", 1, 5, out total);
            gvRecentUsers.DataSource = dt;
            gvRecentUsers.DataBind();
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            string newUsername = txtNewUsername.Text.Trim();
            if (string.IsNullOrEmpty(newUsername))
            {
                litAlert.Text = "<div class='alert alert-danger rounded-4'>Username cannot be empty.</div>";
                return;
            }

            string avatarUrl = null;
            string bannerUrl = null;

            if (fuAvatar.HasFile)
            {
                string ext = Path.GetExtension(fuAvatar.FileName).ToLower();
                string[] allowed = { ".png", ".jpg", ".jpeg", ".webp", ".gif" };
                if (Array.IndexOf(allowed, ext) >= 0)
                {
                    string fileName = "avatar_" + CurrentUserId + "_" + Guid.NewGuid().ToString("N").Substring(0, 6) + ext;
                    string folder = Server.MapPath("~/Uploads/Avatars/");
                    if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                    fuAvatar.SaveAs(Path.Combine(folder, fileName));
                    avatarUrl = "~/Uploads/Avatars/" + fileName;
                }
            }

            if (fuBanner.HasFile)
            {
                string ext = Path.GetExtension(fuBanner.FileName).ToLower();
                string[] allowed = { ".png", ".jpg", ".jpeg", ".webp", ".gif" };
                if (Array.IndexOf(allowed, ext) >= 0)
                {
                    string fileName = "banner_" + CurrentUserId + "_" + Guid.NewGuid().ToString("N").Substring(0, 6) + ext;
                    string folder = Server.MapPath("~/Uploads/Banners/");
                    if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                    fuBanner.SaveAs(Path.Combine(folder, fileName));
                    bannerUrl = "~/Uploads/Banners/" + fileName;
                }
            }

            // Preserve existing border when saving identity
            DataRow existingStats = UserDAL.GetStats(CurrentUserId);
            string existingBorder = existingStats != null && existingStats["border_url"] != DBNull.Value
                ? existingStats["border_url"].ToString() : null;
            string existingAvatar = avatarUrl ?? (existingStats != null && existingStats["avatar_url"] != DBNull.Value
                ? existingStats["avatar_url"].ToString() : null);
            string existingBanner = bannerUrl ?? (existingStats != null && existingStats["banner_url"] != DBNull.Value
                ? existingStats["banner_url"].ToString() : null);

            UserDAL.UpdateProfile(CurrentUserId, newUsername, existingAvatar, existingBanner, existingBorder);
            Session["Username"] = newUsername;

            litAlert.Text = "<div class='alert alert-success rounded-4'>Profile identity &amp; aesthetics successfully updated!</div>";
            LoadAdminProfile();
            LoadInventory();
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