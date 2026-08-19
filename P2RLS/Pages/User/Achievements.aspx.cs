using System;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class Achievements : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptAchievements.DataSource = AchievementDAL.GetForMemberView(CurrentUserId);
                rptAchievements.DataBind();
            }
        }
    }
}