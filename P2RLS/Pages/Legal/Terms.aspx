<%@ Page Title="Terms of Use" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Terms.aspx.cs" Inherits="P2RLS.Pages.Legal.Terms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 max-w-900 mx-auto">
        <!-- Hero Header -->
        <div class="text-center mb-5">
            <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-2 rounded-pill mb-3">
                <i class="bi bi-file-earmark-text-fill me-1"></i> PLATFORM AGREEMENT
            </span>
            <h1 class="display-6 fw-extrabold text-dark mb-3">Terms of Use</h1>
            <p class="text-muted mx-auto" style="max-width: 680px; font-size: 1.05rem; line-height: 1.6;">
                Please read these Terms of Use carefully before using the P2RLS platform, academy courses, and simulation sandboxes.
            </p>
            <div class="small text-muted fw-semibold">
                <i class="bi bi-clock-history me-1"></i> Last Updated: <%= DateTime.Now.ToString("MMMM yyyy") %> &bull; Effective Immediately
            </div>
        </div>

        <!-- Terms Content Card -->
        <div class="card p-4 p-md-5 border-0 shadow-sm mb-4" style="border-radius: 24px; background: #FFFFFF;">
            <!-- 1. Acceptance of Terms -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">1</span>
                    Acceptance of Agreement
                </h2>
                <p class="text-secondary leading-relaxed">
                    By accessing, creating an account on, or interacting with P2RLS, you agree to be bound by these Terms of Use, our Privacy Policy, and all applicable guidelines. If you do not agree to these terms, you must discontinue your use of the platform immediately.
                </p>
            </div>

            <!-- 2. Purely Educational Purpose -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">2</span>
                    Educational Nature of Platform
                </h2>
                <div class="p-4 rounded-4 mb-3" style="background: #F0FDF4; border: 1px solid #BBF7D0;">
                    <div class="d-flex align-items-start gap-3">
                        <i class="bi bi-info-circle-fill text-success fs-3 mt-1"></i>
                        <div>
                            <div class="fw-bold text-dark mb-1">Simulated Learning Environment</div>
                            <p class="text-muted small mb-0">
                                All lessons, case studies, financial models, quizzes, and market sandboxes provided on P2RLS are designed solely for <strong>instructional and educational purposes</strong>.
                            </p>
                        </div>
                    </div>
                </div>
                <p class="text-secondary">
                    No content published on P2RLS constitutes professional investment advice, financial planning endorsement, legal counsel, or tax recommendation. Users are urged to perform independent due diligence.
                </p>
            </div>

            <!-- 3. Virtual Coins & Economy -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">3</span>
                    Virtual Economy &amp; Coins Policy
                </h2>
                <ul class="text-secondary ps-3 mb-0" style="line-height: 1.8;">
                    <li><strong>No Fiat Value:</strong> Virtual coins earned from quizzes, milestones, and challenges possess no real-world monetary value and cannot be redeemed for legal tender, cryptocurrency, or real cash.</li>
                    <li><strong>In-Platform Utility:</strong> Coins may only be used within P2RLS to unlock virtual shop cosmetics (avatars, background banners, title tags, and profile border frames).</li>
                    <li><strong>Non-Transferable:</strong> Virtual currency and cosmetic assets are linked solely to your personal account and cannot be sold, bartered, or transferred to other accounts.</li>
                </ul>
            </div>

            <!-- 4. Account Responsibilities -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">4</span>
                    Account Responsibilities &amp; Fair Play
                </h2>
                <p class="text-secondary mb-3">
                    You are responsible for maintaining the confidentiality of your account login credentials. You agree not to:
                </p>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="p-3 rounded-4 h-100" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                            <div class="fw-bold text-dark small mb-1"><i class="bi bi-x-circle-fill text-danger me-2"></i>Automation &amp; Bots</div>
                            <p class="text-muted small mb-0">Use automated scripts, spiders, or scrapers to manipulate quiz results, simulate fake activity, or exploit coins.</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 rounded-4 h-100" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                            <div class="fw-bold text-dark small mb-1"><i class="bi bi-x-circle-fill text-danger me-2"></i>Impersonation &amp; Abuse</div>
                            <p class="text-muted small mb-0">Impersonate platform administrators, disrupt community boards, or upload offensive custom profile media.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 5. Intellectual Property -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">5</span>
                    Intellectual Property
                </h2>
                <p class="text-secondary">
                    All curriculum structures, interactive scenarios, illustrations, badges, logos, and software code are the intellectual property of P2RLS and protected by applicable copyright and trademark laws. Unauthorized reproduction or commercial distribution is prohibited.
                </p>
            </div>

            <!-- 6. Modifications & Termination -->
            <div>
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">6</span>
                    Modifications &amp; Termination
                </h2>
                <p class="text-secondary mb-3">
                    We reserve the right to update these terms, modify curriculum modules, or terminate access for accounts that breach our community guidelines without prior notice.
                </p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="~/Pages/User/Lessons.aspx" class="btn btn-brand rounded-pill px-4 btn-sm fw-bold" runat="server">
                        <i class="bi bi-journal-bookmark-fill me-1"></i> Start Learning
                    </a>
                    <a href="~/Pages/Legal/RiskDisclosure.aspx" class="btn btn-outline-secondary rounded-pill px-4 btn-sm fw-semibold" runat="server">
                        <i class="bi bi-shield-exclamation me-1"></i> View Risk Disclosure
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
