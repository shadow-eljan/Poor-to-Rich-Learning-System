// Location: /App_Code/BLL/RewardService.cs
using P2RLS.DAL;

namespace P2RLS.BLL
{
    public enum PurchaseResult { Success, InsufficientCoins, AlreadyOwned, ItemNotFound }

    public static class RewardService
    {
        public static PurchaseResult Purchase(int userId, int itemId)
        {
            switch (RewardItemDAL.Purchase(userId, itemId))
            {
                case 1: return PurchaseResult.Success;
                case 0: return PurchaseResult.InsufficientCoins;
                case -1: return PurchaseResult.AlreadyOwned;
                default: return PurchaseResult.ItemNotFound;
            }
        }
    }
}