// Location: /App_Code/BLL/UserService.cs
using P2RLS.DAL;
using P2RLS.Models;
using P2RLS.Security;

namespace P2RLS.BLL
{
    public enum RegisterResult { Success, DuplicateUser }

    public static class UserService
    {
        public static RegisterResult Register(string username, string email, string password)
        {
            string hash = PasswordHelper.HashPassword(password);
            int newId = UserDAL.InsertUser(username, email, hash);
            return newId > 0 ? RegisterResult.Success : RegisterResult.DuplicateUser;
        }

        // Returns null for both "no such user" and "wrong password" — deliberately the
        // same outcome, so a failed login never reveals whether the username exists.
        public static UserAccount Login(string username, string password)
        {
            var user = UserDAL.GetUserByUsername(username);
            if (user == null) return null;
            if (!PasswordHelper.VerifyPassword(password, user.PasswordHash)) return null;
            return user;
        }
    }
}