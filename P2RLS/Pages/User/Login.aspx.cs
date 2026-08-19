using System;
using P2RLS.BLL;

namespace P2RLS.Pages.User
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["registered"] == "1")
            {
                litRegisteredMsg.Text = "<div class='alert alert-success'>Account created. You can log in now.</div>";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            var user = UserService.Login(txtUsername.Text.Trim(), txtPassword.Text);
            if (user == null)
            {
                litServerError.Text = "<div class='alert alert-danger'>Invalid username or password.</div>";
                return;
            }

            Session["UserId"] = user.Id;
            Session["Username"] = user.Username;
            Session["Role"] = user.Role;
            Session["VirtualCoins"] = user.VirtualCoins;

            string returnUrl = Request.QueryString["returnUrl"];
            if (IsLocalUrl(returnUrl))
            {
                Response.Redirect(returnUrl);
            }
            else
            {
                Response.Redirect(user.Role == "Admin" ? "~/Pages/Admin/Dashboard.aspx" : "~/Pages/User/Dashboard.aspx");
            }
        }

        // Only allow redirecting to paths within this site — blocks open-redirect attacks
        // via a crafted ?returnUrl=https://evil.com link.
        private bool IsLocalUrl(string url)
        {
            if (string.IsNullOrEmpty(url)) return false;
            if (url.StartsWith("//") || url.Contains("://")) return false;
            return url.StartsWith("/");
        }
    }
}