// Location: /App_Code/Models/UserAccount.cs
namespace P2RLS.Models
{
    public class UserAccount
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string PasswordHash { get; set; }
        public string Role { get; set; }
        public int Level { get; set; }
        public int Exp { get; set; }
        public int VirtualCoins { get; set; }
    }
}