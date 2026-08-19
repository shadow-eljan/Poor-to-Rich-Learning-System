using System;
using System.Data;
using System.IO;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class LessonCategoryEdit : AdminBasePage
    {
        private bool IsEditMode => !string.IsNullOrEmpty(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (IsEditMode)
                LoadCategory(Convert.ToInt32(Request.QueryString["id"]));
            else
                litHeading.Text = "New Category";
        }

        private void LoadCategory(int id)
        {
            DataRow row = LessonCategoryDAL.GetById(id);
            if (row == null)
            {
                Response.Redirect("~/Pages/Admin/LessonCategories.aspx");
                return;
            }

            litHeading.Text = "Edit Category";
            hdnId.Value = row["id"].ToString();
            txtName.Text = row["name"].ToString();
            txtLevelNumber.Text = row["level_number"].ToString();
            txtDescription.Text = row["description"].ToString();

            if (row.Table.Columns.Contains("estimated_time") && row["estimated_time"] != DBNull.Value)
                txtEstimatedTime.Text = row["estimated_time"].ToString();

            if (row.Table.Columns.Contains("image_url") && row["image_url"] != DBNull.Value)
            {
                string imgUrl = row["image_url"].ToString();
                txtImageUrl.Text = imgUrl;
                if (!string.IsNullOrEmpty(imgUrl))
                {
                    imgPreview.ImageUrl = ResolveUrl(imgUrl);
                    phExistingImage.Visible = true;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string name = txtName.Text.Trim();
            int level = Convert.ToInt32(txtLevelNumber.Text.Trim());
            string description = txtDescription.Text.Trim();
            string estimatedTime = txtEstimatedTime.Text.Trim();
            string imageUrl = txtImageUrl.Text.Trim();

            // Handle file upload
            if (fuImage.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuImage.FileName).ToLower();
                    if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                    {
                        string uploadDir = Server.MapPath("~/Uploads/Categories/");
                        if (!Directory.Exists(uploadDir))
                        {
                            Directory.CreateDirectory(uploadDir);
                        }

                        string uniqueFileName = string.Format("cat_lvl_{0}_{1}{2}", level, Guid.NewGuid().ToString("N").Substring(0, 8), ext);
                        string savePath = Path.Combine(uploadDir, uniqueFileName);
                        fuImage.SaveAs(savePath);
                        imageUrl = "~/Uploads/Categories/" + uniqueFileName;
                    }
                }
                catch
                {
                    // Fallback to existing or manual URL if save fails
                }
            }

            if (!string.IsNullOrEmpty(hdnId.Value))
                LessonCategoryDAL.Update(Convert.ToInt32(hdnId.Value), name, level, description, estimatedTime, imageUrl);
            else
                LessonCategoryDAL.Insert(name, level, description, estimatedTime, imageUrl);

            Response.Redirect("~/Pages/Admin/LessonCategories.aspx");
        }
    }
}