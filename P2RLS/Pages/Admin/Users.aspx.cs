using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class Users : AdminBasePage
    {
        private string SortColumn
        {
            get => ViewState["SortColumn"] as string ?? "username";
            set => ViewState["SortColumn"] = value;
        }
        private string SortDirection
        {
            get => ViewState["SortDirection"] as string ?? "ASC";
            set => ViewState["SortDirection"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            int totalRows;
            DataTable dt = UserDAL.GetAllForAdmin(txtSearch.Text.Trim(), SortColumn, SortDirection,
                gvUsers.PageIndex + 1, gvUsers.PageSize, out totalRows);

            gvUsers.VirtualItemCount = totalRows;
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvUsers.PageIndex = 0;
            BindGrid();
        }

        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvUsers_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else { SortColumn = e.SortExpression; SortDirection = "ASC"; }
            gvUsers.PageIndex = 0;
            BindGrid();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleRole")
            {
                string[] parts = e.CommandArgument.ToString().Split('|');
                int id = Convert.ToInt32(parts[0]);
                string currentRole = parts[1];

                if (id == CurrentUserId)
                {
                    litMessage.Text = "<div class='alert alert-warning'>You can't change your own role here.</div>";
                    BindGrid();
                    return;
                }

                string newRole = currentRole == "Admin" ? "Member" : "Admin";
                UserDAL.UpdateRole(id, newRole);
                litMessage.Text = "<div class='alert alert-success'>Role updated.</div>";
                BindGrid();
            }
            else if (e.CommandName == "DeleteUser")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                if (id == CurrentUserId)
                {
                    litMessage.Text = "<div class='alert alert-warning'>You can't delete your own account here.</div>";
                    BindGrid();
                    return;
                }

                try
                {
                    UserDAL.DeleteUser(id);
                    litMessage.Text = "<div class='alert alert-success'>User deleted.</div>";
                }
                catch (SqlException)
                {
                    litMessage.Text = "<div class='alert alert-warning'>Can't delete — this user has activity history that references them.</div>";
                }
                BindGrid();
            }
        }
    }
}