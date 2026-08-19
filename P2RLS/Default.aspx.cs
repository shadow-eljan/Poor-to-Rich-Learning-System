using System;

namespace P2RLS
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                phGuestCta.Visible = false;
                phMemberCta.Visible = true;
                phGuestCta2.Visible = false;
                phMemberCta2.Visible = true;
            }
        }
    }
}