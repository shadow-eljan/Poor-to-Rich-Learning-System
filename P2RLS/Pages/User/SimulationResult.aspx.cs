using System;
using P2RLS.Models;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class SimulationResult : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var result = Session["LastSimulationResult"] as SimulationResultSummary;
            if (result == null) { Response.Redirect("~/Pages/User/Simulations.aspx"); return; }

            litChoice.Text = Server.HtmlEncode(result.Choice);
            litOutcome.Text = Server.HtmlEncode(result.Outcome);
            litExp.Text = result.ExpEarned.ToString();
            litCoins.Text = result.CoinsEarned.ToString();

            if (result.NewAchievements.Count > 0)
                litAchievements.Text = "<div class='alert alert-success'>🏆 Achievement unlocked: "
                    + string.Join(", ", result.NewAchievements.ConvertAll(Server.HtmlEncode)) + "</div>";

            Session.Remove("LastSimulationResult");
        }
    }
}