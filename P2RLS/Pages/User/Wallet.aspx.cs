using System;
using System.Data;
using P2RLS.DAL;
using P2RLS.BLL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class Wallet : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindWallet();
        }

        private void BindWallet()
        {
            DataRow summary = VirtualEconomyDAL.GetWalletSummary(CurrentUserId);
            litCash.Text = summary != null ? summary["Cash"].ToString() : "0";
            litSavings.Text = summary != null ? summary["Savings"].ToString() : "0";

            rptHistory.DataSource = VirtualEconomyDAL.GetTransactionHistory(CurrentUserId, 10);
            rptHistory.DataBind();
        }

        private void RefreshSessionCoins()
        {
            var stats = UserDAL.GetStats(CurrentUserId);
            if (stats != null) Session["VirtualCoins"] = stats["virtual_coins"];
        }

        protected void btnDeposit_Click(object sender, EventArgs e)
        {
            int amount;
            if (!int.TryParse(txtDepositAmount.Text.Trim(), out amount) || amount <= 0)
            {
                litMessage.Text = "<div class='alert alert-warning'>Enter a valid amount.</div>";
                BindWallet(); return;
            }

            var result = VirtualEconomyService.Deposit(CurrentUserId, amount);
            if (result == WalletResult.Success)
            {
                litMessage.Text = "<div class='alert alert-success'>Deposited " + amount + " coins to savings.</div>";
                RefreshSessionCoins();
            }
            else
            {
                litMessage.Text = "<div class='alert alert-danger'>Not enough cash for that deposit.</div>";
            }
            BindWallet();
        }

        protected void btnWithdraw_Click(object sender, EventArgs e)
        {
            int amount;
            if (!int.TryParse(txtWithdrawAmount.Text.Trim(), out amount) || amount <= 0)
            {
                litMessage.Text = "<div class='alert alert-warning'>Enter a valid amount.</div>";
                BindWallet(); return;
            }

            var result = VirtualEconomyService.Withdraw(CurrentUserId, amount);
            if (result == WalletResult.Success)
            {
                litMessage.Text = "<div class='alert alert-success'>Withdrew " + amount + " coins from savings.</div>";
                RefreshSessionCoins();
            }
            else
            {
                litMessage.Text = "<div class='alert alert-danger'>Not enough in savings for that withdrawal.</div>";
            }
            BindWallet();
        }

        protected void btnInvest_Click(object sender, EventArgs e)
        {
            int amount;
            if (!int.TryParse(txtInvestAmount.Text.Trim(), out amount) || amount <= 0)
            {
                litMessage.Text = "<div class='alert alert-warning'>Enter a valid amount.</div>";
                BindWallet(); return;
            }

            var result = VirtualEconomyService.Invest(CurrentUserId, amount, ddlAssetType.SelectedValue);
            if (!result.Success)
            {
                litMessage.Text = "<div class='alert alert-danger'>Not enough cash to invest that amount.</div>";
            }
            else
            {
                string outcome = result.Gained ? "grew to" : "shrank to";
                string cssClass = result.Gained ? "alert-success" : "alert-warning";
                string sign = result.PercentChange >= 0 ? "+" : "";
                litMessage.Text = "<div class='alert " + cssClass + "'>Your " + result.InitialAmount + "-coin investment in "
                    + ddlAssetType.SelectedValue + " " + outcome + " " + result.OutcomeAmount + " coins ("
                    + sign + Math.Round(result.PercentChange * 100) + "%).</div>";
                RefreshSessionCoins();
            }
            BindWallet();
        }
    }
}