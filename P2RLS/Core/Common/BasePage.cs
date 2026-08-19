// Location: /App_Code/Common/BasePage.cs
// Any page that requires a logged-in user should inherit BasePage instead of Page.
using System;
using System.Web.UI;

namespace P2RLS.Common
{
    public class BasePage : Page
    {
        protected int CurrentUserId => Convert.ToInt32(Session["UserId"]);
        protected string CurrentUsername => Session["Username"] as string;
        protected string CurrentRole => Session["Role"] as string;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (Session["UserId"] == null)
            {
                string returnUrl = Server.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect("~/Pages/User/Login.aspx?returnUrl=" + returnUrl);
            }
        }
    }
}