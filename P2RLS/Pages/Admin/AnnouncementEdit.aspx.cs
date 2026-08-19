using System;
using System.Data;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class AnnouncementEdit : AdminBasePage
    {
        private bool IsEditMode => !string.IsNullOrEmpty(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (IsEditMode)
                LoadAnnouncement(Convert.ToInt32(Request.QueryString["id"]));
            else
                litHeading.Text = "New Announcement";
        }

        private void LoadAnnouncement(int id)
        {
            DataRow row = AnnouncementDAL.GetById(id);
            if (row == null) { Response.Redirect("~/Pages/Admin/Announcements.aspx"); return; }

            litHeading.Text = "Edit Announcement";
            hdnId.Value = row["id"].ToString();
            txtTitle.Text = row["title"].ToString();
            txtContent.Text = row["content"].ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string title = txtTitle.Text.Trim();
            string content = txtContent.Text.Trim();

            if (!string.IsNullOrEmpty(hdnId.Value))
                AnnouncementDAL.Update(Convert.ToInt32(hdnId.Value), title, content);
            else
                AnnouncementDAL.Insert(title, content, CurrentUserId); // posted_by = the admin saving it

            Response.Redirect("~/Pages/Admin/Announcements.aspx");
        }
    }
}