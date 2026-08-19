<%@ Page Title="Privacy & Security" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Privacy.aspx.cs" Inherits="P2RLS.Pages.Legal.Privacy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 max-w-900 mx-auto">
        <!-- Hero Header -->
        <div class="text-center mb-5">
            <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-2 rounded-pill mb-3">
                <i class="bi bi-shield-lock-fill me-1"></i> DATA PROTECTION &amp; PRIVACY
            </span>
            <h1 class="display-6 fw-extrabold text-dark mb-3">Privacy &amp; Security Policy</h1>
            <p class="text-muted mx-auto" style="max-width: 680px; font-size: 1.05rem; line-height: 1.6;">
                At P2RLS, we are committed to safeguarding your personal data, privacy, and learning journey with enterprise-grade security practices.
            </p>
            <div class="small text-muted fw-semibold">
                <i class="bi bi-clock-history me-1"></i> Last Updated: <%= DateTime.Now.ToString("MMMM yyyy") %> &bull; Version 2.4
            </div>
        </div>

        <!-- Privacy Content Cards -->
        <div class="card p-4 p-md-5 border-0 shadow-sm mb-4" style="border-radius: 24px; background: #FFFFFF;">
            <!-- 1. Introduction -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">1</span>
                    Overview &amp; Scope
                </h2>
                <p class="text-secondary leading-relaxed">
                    P2RLS (&quot;Platform&quot;, &quot;we&quot;, &quot;us&quot;, or &quot;our&quot;) is a financial literacy and gamified wealth-building education platform. This Privacy Policy describes how we collect, store, utilize, and protect your information when you access our academy modules, simulations, virtual wallet, and community features.
                </p>
            </div>

            <!-- 2. Data We Collect -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">2</span>
                    Information We Collect
                </h2>
                <p class="text-secondary mb-3">
                    We collect minimal personal information necessary to deliver and customize your learning experience:
                </p>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="p-3 rounded-4 h-100" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                            <div class="fw-bold text-dark mb-1"><i class="bi bi-person-badge text-primary me-2"></i>Account Information</div>
                            <p class="text-muted small mb-0">Username, email address, hashed passwords (using PBKDF2/cryptographic hashing), and optional cosmetic avatars.</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 rounded-4 h-100" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                            <div class="fw-bold text-dark mb-1"><i class="bi bi-journal-check text-primary me-2"></i>Learning &amp; Gamification Data</div>
                            <p class="text-muted small mb-0">Completed lesson stages, quiz scores, sandbox simulation choices, badge achievements, and virtual coin balance.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 3. How We Use Your Data -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">3</span>
                    How We Use Your Data
                </h2>
                <ul class="text-secondary ps-3 mb-0" style="line-height: 1.8;">
                    <li><strong>Curriculum Progression:</strong> Track your progression across the 6 stages from Survival to Financial Freedom.</li>
                    <li><strong>Virtual Economy:</strong> Maintain accurate balances for virtual reward coins, cosmetic equips, and shop transactions.</li>
                    <li><strong>Security &amp; Account Protection:</strong> Authenticate sessions, prevent unauthorized access, and protect against fraudulent activity.</li>
                    <li><strong>Continuous Improvement:</strong> Aggregate anonymous usage metrics to improve lesson clarity and interactive simulations.</li>
                </ul>
            </div>

            <!-- 4. Security & Encryption -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">4</span>
                    Security &amp; Encryption Standards
                </h2>
                <div class="p-4 rounded-4 mb-3" style="background: #F5F3FF; border: 1px solid #DDD6FE;">
                    <div class="d-flex align-items-start gap-3">
                        <i class="bi bi-shield-check text-primary fs-3 mt-1"></i>
                        <div>
                            <div class="fw-bold text-dark mb-1">Zero Financial Data Storage</div>
                            <p class="text-muted small mb-0">
                                P2RLS is an educational simulator. We <strong>never</strong> ask for, process, or store credit card numbers, bank account details, or real financial account credentials.
                            </p>
                        </div>
                    </div>
                </div>
                <p class="text-secondary">
                    All communication between your browser and our servers is secured via <strong>TLS/SSL 256-bit encryption</strong>. User passwords are encrypted with high-iteration cryptographic salted hashes and are never stored in plaintext.
                </p>
            </div>

            <!-- 5. Cookies & Local Storage -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">5</span>
                    Cookies &amp; Sessions
                </h2>
                <p class="text-secondary">
                    We use secure HTTP session cookies strictly for session authentication and maintaining your logged-in state. We do not sell user data to third-party ad networks or data brokers.
                </p>
            </div>

            <!-- 6. User Rights -->
            <div>
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">6</span>
                    Your Rights &amp; Data Control
                </h2>
                <p class="text-secondary mb-3">
                    You have the right to review, update, or request the deletion of your account and learning records at any time. You can edit your profile information directly in the User Dashboard or contact our administration.
                </p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="~/Pages/User/Dashboard.aspx" class="btn btn-outline-brand rounded-pill px-4 btn-sm fw-semibold" runat="server">
                        <i class="bi bi-person-gear me-1"></i> Manage Account
                    </a>
                    <a href="mailto:support@p2rls.internal" class="btn btn-outline-secondary rounded-pill px-4 btn-sm fw-semibold">
                        <i class="bi bi-envelope-fill me-1"></i> Contact Security Team
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
