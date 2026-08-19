using System;
using P2RLS.BLL;

namespace P2RLS.Pages.User
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return; // validators already ran server-side — never trust client-side alone

            var result = UserService.Register(txtUsername.Text.Trim(), txtEmail.Text.Trim(), txtPassword.Text);

            if (result == RegisterResult.DuplicateUser)
            {
                litServerError.Text = "<div class='alert alert-danger'>That username or email is already registered.</div>";
                return;
            }

            Response.Redirect("~/Pages/User/Login.aspx?registered=1");
        }
    }
}