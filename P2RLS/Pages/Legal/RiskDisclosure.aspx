<%@ Page Title="Risk Disclosure" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="RiskDisclosure.aspx.cs" Inherits="P2RLS.Pages.Legal.RiskDisclosure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 max-w-900 mx-auto">
        <!-- Hero Header -->
        <div class="text-center mb-5">
            <span class="badge bg-warning bg-opacity-20 text-dark fw-bold px-3 py-2 rounded-pill mb-3">
                <i class="bi bi-exclamation-triangle-fill text-warning me-1"></i> SIMULATION &amp; MARKET DISCLAIMER
            </span>
            <h1 class="display-6 fw-extrabold text-dark mb-3">Financial Risk Disclosure</h1>
            <p class="text-muted mx-auto" style="max-width: 680px; font-size: 1.05rem; line-height: 1.6;">
                Important disclosures regarding educational market simulations, financial modeling, and risk factors in real-world investing.
            </p>
            <div class="small text-muted fw-semibold">
                <i class="bi bi-clock-history me-1"></i> Last Updated: <%= DateTime.Now.ToString("MMMM yyyy") %> &bull; Educational Notice
            </div>
        </div>

        <!-- Risk Disclosure Content Card -->
        <div class="card p-4 p-md-5 border-0 shadow-sm mb-4" style="border-radius: 24px; background: #FFFFFF;">
            <!-- Callout Alert -->
            <div class="p-4 rounded-4 mb-5" style="background: #FFFBEB; border: 1px solid #FDE68A;">
                <div class="d-flex align-items-start gap-3">
                    <i class="bi bi-shield-exclamation text-warning fs-2 mt-1"></i>
                    <div>
                        <h2 class="h6 fw-bold text-dark mb-1">Non-Advisory Educational Notice</h2>
                        <p class="text-secondary small mb-0" style="line-height: 1.6;">
                            P2RLS is an educational platform and simulator designed to foster financial literacy. <strong>None of the content, curriculum lessons, interactive scenarios, or simulation results constitute personalized investment advice, portfolio recommendations, or endorsements of financial products.</strong>
                        </p>
                    </div>
                </div>
            </div>

            <!-- 1. Simulated Performance Disclosures -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">1</span>
                    Simulation vs. Real Market Execution
                </h2>
                <p class="text-secondary mb-3 leading-relaxed">
                    Interactive simulation modules provided on P2RLS (such as high-yield equity allocation, debt snowballs, leverage, and staking models) are mathematical representations intended to demonstrate theoretical financial concepts:
                </p>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="p-3 rounded-4 h-100" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                            <div class="fw-bold text-dark small mb-1"><i class="bi bi-graph-up-arrow text-primary me-2"></i>Hypothetical Returns</div>
                            <p class="text-muted small mb-0">Simulated portfolio gains or coin rewards do not reflect the impact of real market volatility, slippage, liquidity crunches, or real-world execution delay.</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 rounded-4 h-100" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                            <div class="fw-bold text-dark small mb-1"><i class="bi bi-shield-slash text-danger me-2"></i>Zero Real Capital Risk</div>
                            <p class="text-muted small mb-0">In-game outcomes and virtual coin balances are completely risk-free and do not put any real capital or monetary funds at risk.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 2. Real Market Risk Factors -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">2</span>
                    Real-World Market Risk Factors
                </h2>
                <p class="text-secondary mb-3">
                    When applying financial principles learned in this academy to real life, users should remain conscious of inherent financial risks:
                </p>
                <ul class="text-secondary ps-3 mb-0" style="line-height: 1.8;">
                    <li><strong>Capital Loss:</strong> All real-world investing in securities, equities, real estate, and digital assets carries the risk of total loss of invested capital.</li>
                    <li><strong>Market Volatility:</strong> Market prices can fluctuate rapidly due to macroeconomic conditions, geopolitical events, interest rate shifts, and industry disruption.</li>
                    <li><strong>Past Performance:</strong> Historical asset returns or simulation model yields are not indicative of future results.</li>
                    <li><strong>Tax &amp; Legal Implications:</strong> Tax laws, retirement contribution rules, and financial regulations differ by jurisdiction and individual tax residency.</li>
                </ul>
            </div>

            <!-- 3. Cryptocurrencies and Speculative Assets -->
            <div class="mb-5">
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">3</span>
                    Cryptocurrency &amp; High-Volatility Assets
                </h2>
                <p class="text-secondary">
                    Lessons covering digital assets, cryptocurrency, derivatives, or high-risk leverage are provided strictly to analyze historical case studies and modern asset mechanisms. These are not endorsements to buy, sell, or trade any specific cryptocurrency or token.
                </p>
            </div>

            <!-- 4. Independent Financial Advice -->
            <div>
                <h2 class="h5 fw-bold text-dark d-flex align-items-center gap-2 mb-3">
                    <span class="icon-box-purple rounded-3" style="width: 34px; height: 34px; font-size: 1rem;">4</span>
                    Recommendation to Seek Professional Advice
                </h2>
                <p class="text-secondary mb-4">
                    Before making any significant financial decisions, taking on debt, or committing real capital to investment vehicles, you should always consult a <strong>Certified Financial Planner (CFP)</strong>, registered investment advisor, or licensed tax professional tailored to your personal financial situation.
                </p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="~/Pages/User/Simulations.aspx" class="btn btn-brand rounded-pill px-4 btn-sm fw-bold" runat="server">
                        <i class="bi bi-controller me-1"></i> Enter Simulation Sandbox
                    </a>
                    <a href="~/Pages/Legal/Privacy.aspx" class="btn btn-outline-secondary rounded-pill px-4 btn-sm fw-semibold" runat="server">
                        <i class="bi bi-shield-lock me-1"></i> Privacy Policy
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
