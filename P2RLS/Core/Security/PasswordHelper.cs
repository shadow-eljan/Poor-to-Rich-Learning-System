// Location: /App_Code/Security/PasswordHelper.cs
using System;
using System.Security.Cryptography;

namespace P2RLS.Security
{
    public static class PasswordHelper
    {
        private const int SaltSize = 16;
        private const int HashSize = 32;
        private const int Iterations = 100_000; // OWASP-recommended floor for PBKDF2-SHA256
            
        // Stored format: "iterations.saltBase64.hashBase64" — self-describing, so you
        // can raise Iterations later without breaking old hashes still in the DB.
        public static string HashPassword(string password)
        {
            using (var rfc = new Rfc2898DeriveBytes(password, SaltSize, Iterations, HashAlgorithmName.SHA256))
            {
                byte[] salt = rfc.Salt;
                byte[] hash = rfc.GetBytes(HashSize);
                return $"{Iterations}.{Convert.ToBase64String(salt)}.{Convert.ToBase64String(hash)}";
            }
        }

        public static bool VerifyPassword(string password, string stored)
        {
            var parts = stored.Split('.');
            if (parts.Length != 3) return false;

            int iterations = int.Parse(parts[0]);
            byte[] salt = Convert.FromBase64String(parts[1]);
            byte[] hash = Convert.FromBase64String(parts[2]);

            using (var rfc = new Rfc2898DeriveBytes(password, salt, iterations, HashAlgorithmName.SHA256))
            {
                byte[] testHash = rfc.GetBytes(hash.Length);
                return SlowEquals(hash, testHash);
            }
        }

        // Constant-time comparison — prevents timing attacks from a naive == or SequenceEqual
        private static bool SlowEquals(byte[] a, byte[] b)
        {
            uint diff = (uint)a.Length ^ (uint)b.Length;
            for (int i = 0; i < a.Length && i < b.Length; i++)
                diff |= (uint)(a[i] ^ b[i]);
            return diff == 0;
        }
    }
}