// Location: /App_Code/BLL/VirtualEconomyService.cs
using System;
using System.Collections.Generic;
using P2RLS.DAL;
using P2RLS.Models;

namespace P2RLS.BLL
{
    public enum WalletResult { Success, InsufficientFunds }

    public static class VirtualEconomyService
    {
        private class AssetProfile
        {
            public double WinChance;
            public double GainPct;
            public double LossPct;
        }

        // Win chance / gain / loss — higher risk assets swing harder both ways
        private static readonly Dictionary<string, AssetProfile> Profiles = new Dictionary<string, AssetProfile>
        {
            { "Bonds",         new AssetProfile { WinChance = 0.80, GainPct = 0.05, LossPct = -0.02 } },
            { "Mutual Funds",  new AssetProfile { WinChance = 0.60, GainPct = 0.15, LossPct = -0.08 } },
            { "Stocks",        new AssetProfile { WinChance = 0.50, GainPct = 0.30, LossPct = -0.20 } },
            { "Business",      new AssetProfile { WinChance = 0.35, GainPct = 0.50, LossPct = -0.25 } }
        };

        public static WalletResult Deposit(int userId, int amount)
        {
            return VirtualEconomyDAL.Deposit(userId, amount) == 1 ? WalletResult.Success : WalletResult.InsufficientFunds;
        }

        public static WalletResult Withdraw(int userId, int amount)
        {
            return VirtualEconomyDAL.Withdraw(userId, amount) == 1 ? WalletResult.Success : WalletResult.InsufficientFunds;
        }

        public static InvestmentResult Invest(int userId, int amount, string assetType)
        {
            if (!Profiles.ContainsKey(assetType)) return new InvestmentResult { Success = false };

            var profile = Profiles[assetType];
            var rand = new Random();
            bool won = rand.NextDouble() < profile.WinChance;
            double pct = won ? profile.GainPct : profile.LossPct;
            int outcomeAmount = (int)Math.Round(amount * (1 + pct));

            int dbResult = VirtualEconomyDAL.RecordInvestment(userId, amount, assetType, outcomeAmount);
            if (dbResult != 1) return new InvestmentResult { Success = false };

            return new InvestmentResult
            {
                Success = true,
                InitialAmount = amount,
                OutcomeAmount = outcomeAmount,
                Gained = outcomeAmount >= amount,
                PercentChange = pct
            };
        }
    }
}