using System;
using P2RLS.DAL;

namespace P2RLS.Pages.User
{
    // Deliberately NOT inheriting BasePage — announcements count as public platform
    // information a Guest can browse, per the site's role definitions.
    public partial class Announcements : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var data = AnnouncementDAL.GetForMemberView();
                litEmpty.Text = data.Rows.Count == 0 ? "<p class='text-muted'>No announcements yet.</p>" : "";
                rptAnnouncements.DataSource = data;
                rptAnnouncements.DataBind();
            }
        }
    }
}