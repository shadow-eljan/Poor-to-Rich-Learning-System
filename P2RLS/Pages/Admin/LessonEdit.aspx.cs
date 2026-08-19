using System;
using System.Data;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class LessonEdit : AdminBasePage
    {
        private bool IsEditMode => !string.IsNullOrEmpty(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            BindCategoryDropdown();

            if (IsEditMode)
                LoadLesson(Convert.ToInt32(Request.QueryString["id"]));
            else
                litHeading.Text = "New Lesson";
        }

        private void BindCategoryDropdown()
        {
            var categories = LessonDAL.GetCategoriesForDropdown();
            ddlCategory.DataSource = categories;
            ddlCategory.DataTextField = "name";
            ddlCategory.DataValueField = "id";
            ddlCategory.DataBind();
        }

        private void LoadLesson(int id)
        {
            DataRow row = LessonDAL.GetById(id);
            if (row == null)
            {
                Response.Redirect("~/Pages/Admin/Lessons.aspx");
                return;
            }

            litHeading.Text = "Edit Lesson";
            hdnId.Value = row["id"].ToString();
            ddlCategory.SelectedValue = row["category_id"].ToString();
            txtTitle.Text = row["title"].ToString();
            txtContent.Text = row["content"].ToString();
            txtOrderIndex.Text = row["order_index"].ToString();

            if (row.Table.Columns.Contains("key_takeaways") && row["key_takeaways"] != DBNull.Value)
                txtKeyTakeaways.Text = row["key_takeaways"].ToString();

            if (row.Table.Columns.Contains("quote") && row["quote"] != DBNull.Value)
                txtQuote.Text = row["quote"].ToString();

            if (row.Table.Columns.Contains("quote_author") && row["quote_author"] != DBNull.Value)
                txtQuoteAuthor.Text = row["quote_author"].ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            string title = txtTitle.Text.Trim();
            string content = txtContent.Text.Trim();
            string keyTakeaways = txtKeyTakeaways.Text.Trim();
            string quote = txtQuote.Text.Trim();
            string quoteAuthor = txtQuoteAuthor.Text.Trim();

            // Parse order index — default to 0
            int orderIndex;
            if (!int.TryParse(txtOrderIndex.Text.Trim(), out orderIndex))
                orderIndex = 0;

            if (!string.IsNullOrEmpty(hdnId.Value))
                LessonDAL.Update(Convert.ToInt32(hdnId.Value), categoryId, title, content, orderIndex, keyTakeaways, quote, quoteAuthor);
            else
                LessonDAL.Insert(categoryId, title, content, orderIndex, keyTakeaways, quote, quoteAuthor);

            Response.Redirect("~/Pages/Admin/Lessons.aspx");
        }
    }
}