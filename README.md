# 🌟 Poor-to-Rich Learning System (P2RLS)

[![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.7.2-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)](https://dotnet.microsoft.com/)
[![ASP.NET](https://img.shields.io/badge/ASP.NET-Web%20Forms-0078D7?style=for-the-badge&logo=visual-studio&logoColor=white)](https://dotnet.microsoft.com/apps/aspnet)
[![C#](https://img.shields.io/badge/Language-C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[![Database](https://img.shields.io/badge/Database-MS%20SQL%20Server-CC292B?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](https://www.microsoft.com/sql-server/)
[![Bootstrap](https://img.shields.io/badge/UI-Bootstrap%205-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

> **Learn Then Earn. Build Wealth. Secure Your Future.**
> **P2RLS** is a full-featured, gamified financial literacy web platform engineered to empower users on their journey from financial fundamentals to wealth building through structured lessons, interactive real-world simulations, quizzes, and a virtual coin economy. Visit the Site through (http://p2rls.runasp.net)

---

## 📑 Table of Contents
1. [Platform Overview](#-platform-overview)
2. [Core Architecture & Technologies](#-core-architecture--technologies)
3. [Key Features & Modules](#-key-features--modules)
   - [6-Tier Progressive Academy](#1-6-tier-progressive-academy)
   - [Interactive Quizzes & Instant Feedback](#2-interactive-quizzes--instant-feedback)
   - [Real-World Financial Simulations](#3-real-world-financial-simulations)
   - [Virtual Economy & Wallet System](#4-virtual-economy--wallet-system)
   - [Reward Shop & Gamification](#5-reward-shop--gamification)
   - [Comprehensive Dashboards](#6-comprehensive-dashboards)
   - [Administration & Content Management Suite](#7-administration--content-management-suite)
4. [Security & Data Integrity](#-security--data-integrity)
5. [Directory Structure](#-directory-structure)
6. [Getting Started & Installation](#-getting-started--installation)
   - [Prerequisites](#prerequisites)
   - [Configuration & Running](#configuration--running)
7. [Database Architecture](#-database-architecture)
8. [Contributing & License](#-contributing--license)

---

## 💡 Platform Overview

Financial literacy is often dry, theoretical, or intimidating. **P2RLS (Poor-to-Rich Learning System)** bridges the knowledge gap by turning personal finance into an engaging, interactive, risk-free experience. 

Users advance through an educational roadmap—from budgeting and credit management to investing, portfolio allocation, and wealth preservation. Each milestone grants **Experience Points (EXP)** and **Virtual Coins**, which can be managed in a virtual wallet, used in market simulations, or redeemed in the Reward Shop for badges and profile customization items.

---

## 🏛 Core Architecture & Technologies

P2RLS is built following a clean **N-Tier / Layered Architecture**:

```
┌─────────────────────────────────────────────────────────────┐
│               PRESENTATION LAYER (ASP.NET Web Forms)        │
│    Pages/User  •  Pages/Admin  •  Pages/Shared  •  Styles    │
└──────────────────────────────┬──────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────┐
│             BUSINESS LOGIC LAYER (Core/BLL)                 │
│  QuizService • SimulationService • UserService • Economy    │
└──────────────────────────────┬──────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────┐
│              DATA ACCESS LAYER (Core/DAL)                   │
│   DbHelper • UserDAL • LessonDAL • QuizDAL • EconomyDAL     │
└──────────────────────────────┬──────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────┐
│            DATA PERSISTENCE (Microsoft SQL Server)          │
│          Stored Procedures • Parameterized Queries          │
└─────────────────────────────────────────────────────────────┘
```

### Technology Breakdown
- **Runtime & Framework**: ASP.NET Web Forms on .NET Framework 4.7.2
- **Language**: C# 7.3+ / 8.0
- **Database Access**: ADO.NET with SQL Stored Procedures and strong parameterization
- **Styling & UI**: Modern CSS3 Custom Properties (Variables), Bootstrap 5.2.3, Bootstrap Icons, Glassmorphic components, Responsive Flex/Grid
- **Security**: Cryptographic PBKDF2-SHA256 password hashing with unique salt (100,000 iterations), Anti-CSRF verification, Session hardening, Role-based route authorization

---

## ✨ Key Features & Modules

### 1. 🎓 6-Tier Progressive Academy
- **Level 1**: Financial Basics & Budgeting
- **Level 2**: Debt Management & Credit Score Optimization
- **Level 3**: Emergency Funds & High-Yield Savings Strategies
- **Level 4**: Stock Market, Index Funds & Mutual Fund Investing
- **Level 5**: Advanced Wealth Creation, Real Estate & Alternative Assets
- **Level 6**: Financial Independence, Tax Efficiency & Asset Allocation
- Categorized lesson view with reading duration, difficulty tags, and completion tracking.

### 2. 🧠 Interactive Quizzes & Instant Feedback
- Quizzes dynamically associated with academy lessons.
- Real-time scoring calculation with pass/fail evaluation.
- Explanations for correct answers to reinforce learning.
- Rewards users with EXP and Virtual Coins upon successful completion.

### 3. 📈 Real-World Financial Simulations
- Branching decision simulations (e.g., Stock Market Crash scenarios, Crypto vs. Index Funds, Real Estate Down Payment vs. Renting, Emergency Fund crisis management).
- Dynamic risk/reward financial calculations with score multipliers and payout evaluations.

### 4. 🪙 Virtual Economy & Wallet System
- Dedicated virtual wallet tracking coin balance, savings vault, and investment returns.
- Deposit & withdrawal functionality into high-yield virtual savings.
- Comprehensive transaction history ledger with timestamped logs.

### 5. 🛍️ Reward Shop & Gamification
- Unlockable rank titles (Novice, Saver, Investor, Asset Builder, Wealth Master).
- Custom avatar frames, profile banners, and collectible badges.
- Dynamic level progression based on cumulative EXP.

### 6. 📊 Comprehensive Dashboards
- **Member Dashboard**: Real-time financial health score, daily learning streak, course completion progress bar, recent activity, and latest system announcements.
- **Admin Dashboard**: System metrics including registered user counts, lesson engagement, quiz pass rates, and virtual economy circulation.

### 7. 🛠️ Administration & Content Management Suite
- Complete CRUD operations for:
  - Categories & Lessons
  - Quiz Questions & Multiple Choice Options
  - Financial Simulations & Decision Trees
  - Reward Shop Inventory Items
  - System Announcements & Platform Achievements
  - User Accounts & Role Permissions (Member vs Admin) with search, sorting, and pagination.

---

## 🔒 Security & Data Integrity

- **Cryptographic Password Hashing**: Utilizes `Rfc2898DeriveBytes` (PBKDF2 with SHA-256, 16-byte salt, 100,000 iterations) with constant-time equality comparisons (`SlowEquals`) to protect against timing attacks.
- **SQL Injection Immunity**: 100% of database interactions execute through `DbHelper.cs` utilizing named SQL Stored Procedures and typed `SqlParameter` collections. No raw concatenated SQL queries.
- **Session & Cookie Hardening**: Configured with `httpOnlyCookies="true"`, custom error routing (`RemoteOnly`), and request size limits in `Web.config`.
- **Role-Based Access Control**: Centralized `BasePage` and `AdminBasePage` classes validate authentication tokens and enforce role hierarchies before rendering protected views.

---

## 📁 Directory Structure

```
P2RLS/
├── .gitignore                      # Git ignore rules for .NET / Visual Studio
├── P2RLS.slnx                      # Solution definition file
├── README.md                       # Comprehensive project documentation
└── P2RLS/                          # Main Application Root
    ├── App_Start/                  # Application startup configs (BundleConfig, RouteConfig)
    ├── Core/                       # Core Backend Architecture
    │   ├── BLL/                    # Business Logic Layer (Services)
    │   │   ├── QuizService.cs
    │   │   ├── RewardService.cs
    │   │   ├── SimulationService.cs
    │   │   ├── UserService.cs
    │   │   └── VirtualEconomyService.cs
    │   ├── Common/                 # Base page handlers & access guards
    │   │   ├── BasePage.cs
    │   │   └── AdminBasePage.cs
    │   ├── DAL/                    # Data Access Layer & Stored Procedure Gateways
    │   │   ├── DbHelper.cs
    │   │   ├── UserDAL.cs
    │   │   ├── LessonDAL.cs
    │   │   ├── LessonCategoryDAL.cs
    │   │   ├── QuizDAL.cs
    │   │   ├── QuizQuestionDAL.cs
    │   │   ├── FinancialSimulationDAL.cs
    │   │   ├── RewardItemDAL.cs
    │   │   ├── AchievementDAL.cs
    │   │   ├── AnnouncementDAL.cs
    │   │   └── VirtualEconomyDAL.cs
    │   ├── Models/                 # DTOs and Data Models
    │   │   ├── UserAccount.cs
    │   │   ├── QuizResultSummary.cs
    │   │   ├── SimulationChoice.cs
    │   │   ├── SimulationResultSummary.cs
    │   │   └── InvestmentResult.cs
    │   └── Security/               # Cryptographic utilities
    │       └── PasswordHelper.cs
    ├── Pages/                      # Presentation Layer
    │   ├── Admin/                  # Administrative CRUD & analytics
    │   ├── User/                   # Member portal (Dashboard, Lessons, Quizzes, Wallet, Shop)
    │   ├── Legal/                  # Privacy, Terms of Service, Risk Disclosures
    │   └── Shared/                 # Error pages and Site master pages
    ├── Scripts/                    # Client-side JavaScript (Bootstrap, jQuery, AJAX)
    ├── Styles/                     # Global CSS stylesheets (Site.css)
    ├── Uploads/                    # User & system uploaded media
    │   ├── Avatars/
    │   ├── Banners/
    │   ├── Borders/
    │   ├── Categories/
    │   └── Rewards/
    ├── Default.aspx                # Landing page
    ├── Web.config                  # Application configuration & connection strings
    └── packages.config             # NuGet dependency declarations
```

---

## 🚀 Getting Started & Installation

### Prerequisites
- **Visual Studio 2019 / 2022** (with *.NET desktop development* and *ASP.NET and web development* workloads)
- **.NET Framework 4.7.2 Developer Pack**
- **Microsoft SQL Server 2016+** or Azure / remote SQL Server instance
- **IIS Express** (included with Visual Studio)

### Configuration & Running

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/shadow-eljan/Poor-to-Rich-Learning-System.git
   cd Poor-to-Rich-Learning-System
   ```

2. **Restore NuGet Packages**:
   Open the solution in Visual Studio and build the solution, or run:
   ```bash
   nuget restore P2RLS\packages.config -PackagesDirectory packages
   ```

3. **Configure Database Connection**:
   Open `P2RLS/Web.config` and update the connection string under `<connectionStrings>`:
   ```xml
   <connectionStrings>
       <add name="P2RLSConnection"
            connectionString="Server=YOUR_SERVER;Database=YOUR_DB;User Id=YOUR_USER;Password=YOUR_PASSWORD;Encrypt=False;MultipleActiveResultSets=True;"
            providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```

4. **Launch Application**:
   - Set `Default.aspx` or `P2RLS` project as the StartUp item in Visual Studio.
   - Press <kbd>F5</kbd> or <kbd>Ctrl</kbd> + <kbd>F5</kbd> to launch via IIS Express in your default browser.

---

## 🗄 Database Architecture

The platform relies on a normalized relational database supporting the following primary entities:
- **`Users`**: User credentials, role (`Member`/`Admin`), current EXP, Level, and Virtual Coins.
- **`LessonCategories`**: Categorization by tier and mastery topic.
- **`Lessons`**: Educational content, reading time, difficulty rating, and reward points.
- **`QuizQuestions` & `QuizOptions`**: Lesson-bound interactive questions and answer keys.
- **`QuizResults`**: User quiz performance, score percentage, and payout records.
- **`FinancialSimulations`**: Simulation scenarios with branching decision options.
- **`RewardItems` & `UserInventory`**: Digital assets, custom cosmetics, and ownership records.
- **`WalletTransactions`**: Full financial ledger for virtual economy tracking.
- **`Achievements` & `Announcements`**: System alerts, broadcast messages, and milestone tracking.

---

## 📄 License

This project is developed for educational and portfolio purposes.
