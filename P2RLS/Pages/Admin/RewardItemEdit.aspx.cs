using System;
using System.Data;
using System.IO;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class RewardItemEdit : AdminBasePage
    {
        private bool IsEditMode => !string.IsNullOrEmpty(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (IsEditMode)
                LoadItem(Convert.ToInt32(Request.QueryString["id"]));
            else
                litHeading.Text = "New Reward Item";
        }

        private void LoadItem(int id)
        {
            DataRow row = RewardItemDAL.GetById(id);
            if (row == null) { Response.Redirect("~/Pages/Admin/RewardItems.aspx"); return; }

            litHeading.Text = "Edit Reward Item";
            hdnId.Value = row["id"].ToString();
            txtName.Text = row["name"].ToString();
            
            string cat = row["category"] != null ? row["category"].ToString() : "Cosmetic";
            if (ddlCategory.Items.FindByValue(cat) != null)
                ddlCategory.SelectedValue = cat;

            txtCost.Text = row["cost"].ToString();
            txtType.Text = row["type"] != null ? row["type"].ToString() : "";

            if (row["image_url"] != DBNull.Value && !string.IsNullOrEmpty(row["image_url"].ToString()))
            {
                string imgUrl = row["image_url"].ToString();
                hdnExistingImageUrl.Value = imgUrl;
                imgPreview.ImageUrl = ResolveUrl(imgUrl);
                phPreview.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string name = txtName.Text.Trim();
            string category = ddlCategory.SelectedValue;
            int cost = Convert.ToInt32(txtCost.Text.Trim());
            string type = txtType.Text.Trim();
            string imageUrl = hdnExistingImageUrl.Value;

            if (fuAssetImage.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuAssetImage.FileName).ToLower();
                    string[] allowed = { ".png", ".jpg", ".jpeg", ".webp", ".gif", ".svg" };
                    if (Array.IndexOf(allowed, ext) >= 0)
                    {
                        // Enforce 10 MB client-side guard (matches Web.config)
                        if (fuAssetImage.PostedFile.ContentLength > 10 * 1024 * 1024)
                        {
                            litAlert.Text = "<div class='alert alert-danger rounded-4'>Image file is too large. Maximum size is 10 MB.</div>";
                            return;
                        }

                        string fileName = "reward_" + Guid.NewGuid().ToString("N").Substring(0, 8) + ext;
                        string targetFolder = Server.MapPath("~/Uploads/Rewards/");
                        if (!Directory.Exists(targetFolder))
                            Directory.CreateDirectory(targetFolder);

                        string savePath = Path.Combine(targetFolder, fileName);
                        fuAssetImage.SaveAs(savePath);
                        imageUrl = "~/Uploads/Rewards/" + fileName;
                    }
                    else
                    {
                        litAlert.Text = "<div class='alert alert-danger rounded-4'>Invalid file type. Allowed: PNG, JPG, JPEG, WEBP, GIF, SVG.</div>";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    litAlert.Text = "<div class='alert alert-danger rounded-4'>Image upload failed: " + Server.HtmlEncode(ex.Message) + "</div>";
                    return;
                }
            }

            if (!string.IsNullOrEmpty(hdnId.Value))
                RewardItemDAL.Update(Convert.ToInt32(hdnId.Value), name, category, cost, type, imageUrl);
            else
                RewardItemDAL.Insert(name, category, cost, type, imageUrl);

            Response.Redirect("~/Pages/Admin/RewardItems.aspx");
        }
    }
}
