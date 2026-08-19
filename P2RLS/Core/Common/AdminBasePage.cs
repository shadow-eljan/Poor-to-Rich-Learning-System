// Location: /App_Code/Common/AdminBasePage.cs
// Any /Pages/Admin/*.aspx page should inherit AdminBasePage instead of Page.
using System;

namespace P2RLS.Common
{
    public class AdminBasePage : BasePage
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e); // login check runs first

            if (CurrentRole != "Admin")
            {
                Response.Redirect("~/Default.aspx?denied=1");
            }
        }
    }
}