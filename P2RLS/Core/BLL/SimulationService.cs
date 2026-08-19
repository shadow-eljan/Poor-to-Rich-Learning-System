// Location: /App_Code/BLL/SimulationService.cs
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using P2RLS.DAL;
using P2RLS.Models;

namespace P2RLS.BLL
{
    public static class SimulationService
    {
        private const int ExpReward = 5;   // flat reward — no "correct" choice to grade
        private const int CoinsReward = 10;

        public static SimulationResultSummary SubmitDecision(int userId, int simulationId, int choiceIndex)
        {
            DataRow sim = FinancialSimulationDAL.GetForTake(simulationId);
            if (sim == null) return null;

            var choices = new JavaScriptSerializer().Deserialize<List<SimulationChoice>>(sim["options"].ToString());
            if (choiceIndex < 0 || choiceIndex >= choices.Count) return null;

            SimulationChoice selected = choices[choiceIndex];

            FinancialSimulationDAL.SaveResult(userId, simulationId, selected.Choice, selected.Outcome);
            UserDAL.AddRewards(userId, ExpReward, CoinsReward);

            var newAchievements = new List<string>();
            DataTable unlocked = AchievementDAL.CheckAndAward(userId);
            foreach (DataRow row in unlocked.Rows) newAchievements.Add(row["name"].ToString());

            DataRow finalStats = UserDAL.GetStats(userId);

            return new SimulationResultSummary
            {
                Choice = selected.Choice,
                Outcome = selected.Outcome,
                ExpEarned = ExpReward,
                CoinsEarned = CoinsReward,
                NewCoinsBalance = finalStats != null ? Convert.ToInt32(finalStats["virtual_coins"]) : 0,
                NewAchievements = newAchievements
            };
        }
    }
}