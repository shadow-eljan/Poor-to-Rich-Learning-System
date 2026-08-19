// Location: /Pages/Shared/Site.master.cs
using System;
using System.Data;
using System.Web.UI;
using P2RLS.DAL;

namespace P2RLS.Pages.Shared
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                phGuestLinks.Visible = false;
                phUserLinks.Visible  = true;

                string username = Session["Username"] as string ?? "";
                litUsername.Text = Server.HtmlEncode(username);
                litCoins.Text    = (Session["VirtualCoins"] ?? 0).ToString();

                // ── Navbar avatar: pull fresh from DB each load ───────────────
                int userId = Convert.ToInt32(Session["UserId"]);
                DataRow stats = UserDAL.GetStats(userId);

                string avatarUrl = stats != null
                    && stats.Table.Columns.Contains("avatar_url")
                    && stats["avatar_url"] != DBNull.Value
                    ? stats["avatar_url"].ToString() : null;

                if (!string.IsNullOrEmpty(avatarUrl))
                {
                    imgNavAvatar.ImageUrl        = ResolveUrl(avatarUrl);
                    imgNavAvatar.Visible         = true;
                    divNavAvatarFallback.Visible = false;
                }
                else
                {
                    imgNavAvatar.Visible         = false;
                    divNavAvatarFallback.Visible = true;
                    litNavInitial.Text = username.Length > 0
                        ? username.Substring(0, 1).ToUpper() : "U";
                }

                // Route profile link
                if (Session["Role"] as string == "Admin")
                {
                    phAdminLink.Visible  = true;
                    lnkUserProfile.HRef = ResolveUrl("~/Pages/Admin/Dashboard.aspx");
                }
                else
                {
                    lnkUserProfile.HRef = ResolveUrl("~/Pages/User/Dashboard.aspx");
                }
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Default.aspx");
        }
    }
}