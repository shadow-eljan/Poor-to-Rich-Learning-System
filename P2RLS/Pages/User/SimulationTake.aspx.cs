using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.BLL;
using P2RLS.Models;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class SimulationTake : BasePage
    {
        private int SimulationId => Convert.ToInt32(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            DataRow sim = FinancialSimulationDAL.GetForTake(SimulationId);
            if (sim == null) { Response.Redirect("~/Pages/User/Simulations.aspx"); return; }

            litTitle.Text = Server.HtmlEncode(sim["title"].ToString());
            litDescription.Text = Server.HtmlEncode(sim["description"].ToString());

            var choices = new JavaScriptSerializer().Deserialize<List<SimulationChoice>>(sim["options"].ToString());
            rptChoices.DataSource = choices;
            rptChoices.DataBind();
        }

        protected void rptChoices_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Choose") return;
            int choiceIndex = Convert.ToInt32(e.CommandArgument);

            var result = SimulationService.SubmitDecision(CurrentUserId, SimulationId, choiceIndex);
            if (result == null)
            {
                litMessage.Text = "<div class='alert alert-danger'>Something went wrong — try again.</div>";
                return;
            }

            Session["VirtualCoins"] = result.NewCoinsBalance;
            Session["LastSimulationResult"] = result;
            Response.Redirect("~/Pages/User/SimulationResult.aspx");
        }
    }
}