using System;
using System.Data;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class AchievementEdit : AdminBasePage
    {
        private bool IsEditMode => !string.IsNullOrEmpty(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (IsEditMode)
                LoadAchievement(Convert.ToInt32(Request.QueryString["id"]));
            else
                litHeading.Text = "New Achievement";
        }

        private void LoadAchievement(int id)
        {
            DataRow row = AchievementDAL.GetById(id);
            if (row == null) { Response.Redirect("~/Pages/Admin/Achievements.aspx"); return; }

            litHeading.Text = "Edit Achievement";
            hdnId.Value = row["id"].ToString();
            txtName.Text = row["name"].ToString();
            txtDescription.Text = row["description"].ToString();
            txtRewardCoins.Text = row["reward_coins"].ToString();
            ddlConditionType.SelectedValue = row["condition_type"].ToString();
            txtConditionValue.Text = row["condition_value"].ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string name = txtName.Text.Trim();
            string description = txtDescription.Text.Trim();
            int rewardCoins = Convert.ToInt32(txtRewardCoins.Text.Trim());
            string conditionType = ddlConditionType.SelectedValue;
            int conditionValue = Convert.ToInt32(txtConditionValue.Text.Trim());

            if (!string.IsNullOrEmpty(hdnId.Value))
                AchievementDAL.Update(Convert.ToInt32(hdnId.Value), name, description, rewardCoins, conditionType, conditionValue);
            else
                AchievementDAL.Insert(name, description, rewardCoins, conditionType, conditionValue);

            Response.Redirect("~/Pages/Admin/Achievements.aspx");
        }
    }
}