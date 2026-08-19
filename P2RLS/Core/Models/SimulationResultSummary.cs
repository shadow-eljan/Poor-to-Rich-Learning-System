// Location: /App_Code/Models/SimulationResultSummary.cs
using System.Collections.Generic;

namespace P2RLS.Models
{
    public class SimulationResultSummary
    {
        public string Choice { get; set; }
        public string Outcome { get; set; }
        public int ExpEarned { get; set; }
        public int CoinsEarned { get; set; }
        public int NewCoinsBalance { get; set; }
        public List<string> NewAchievements { get; set; } = new List<string>();
    }
}