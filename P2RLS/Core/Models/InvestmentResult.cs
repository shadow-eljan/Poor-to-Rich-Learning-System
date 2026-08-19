// Location: /App_Code/Models/InvestmentResult.cs
namespace P2RLS.Models
{
    public class InvestmentResult
    {
        public bool Success { get; set; }
        public int InitialAmount { get; set; }
        public int OutcomeAmount { get; set; }
        public bool Gained { get; set; }
        public double PercentChange { get; set; }
    }
}