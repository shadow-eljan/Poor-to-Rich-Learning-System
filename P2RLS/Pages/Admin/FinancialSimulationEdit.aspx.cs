using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using P2RLS.DAL;
using P2RLS.Models;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class FinancialSimulationEdit : AdminBasePage
    {
        private bool IsEditMode => !string.IsNullOrEmpty(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (IsEditMode)
                LoadSimulation(Convert.ToInt32(Request.QueryString["id"]));
            else
                litHeading.Text = "New Simulation";
        }

        private void LoadSimulation(int id)
        {
            DataRow row = FinancialSimulationDAL.GetById(id);
            if (row == null) { Response.Redirect("~/Pages/Admin/FinancialSimulations.aspx"); return; }

            litHeading.Text = "Edit Simulation";
            hdnId.Value = row["id"].ToString();
            txtTitle.Text = row["title"].ToString();
            txtDescription.Text = row["description"].ToString();
            txtLevelNumber.Text = row["level_number"].ToString();

            string optionsJson = row["options"] == DBNull.Value ? null : row["options"].ToString();
            if (!string.IsNullOrEmpty(optionsJson))
            {
                var choices = new JavaScriptSerializer().Deserialize<List<SimulationChoice>>(optionsJson);
                if (choices.Count > 0) { txtChoice1.Text = choices[0].Choice; txtOutcome1.Text = choices[0].Outcome; }
                if (choices.Count > 1) { txtChoice2.Text = choices[1].Choice; txtOutcome2.Text = choices[1].Outcome; }
                if (choices.Count > 2) { txtChoice3.Text = choices[2].Choice; txtOutcome3.Text = choices[2].Outcome; }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            int levelNumber = Convert.ToInt32(txtLevelNumber.Text.Trim());

            var choices = new List<SimulationChoice>
            {
                new SimulationChoice { Choice = txtChoice1.Text.Trim(), Outcome = txtOutcome1.Text.Trim() },
                new SimulationChoice { Choice = txtChoice2.Text.Trim(), Outcome = txtOutcome2.Text.Trim() },
                new SimulationChoice { Choice = txtChoice3.Text.Trim(), Outcome = txtOutcome3.Text.Trim() }
            };
            string optionsJson = new JavaScriptSerializer().Serialize(choices);

            if (!string.IsNullOrEmpty(hdnId.Value))
                FinancialSimulationDAL.Update(Convert.ToInt32(hdnId.Value), title, description, levelNumber, optionsJson);
            else
                FinancialSimulationDAL.Insert(title, description, levelNumber, optionsJson);

            Response.Redirect("~/Pages/Admin/FinancialSimulations.aspx");
        }
    }
}