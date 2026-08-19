<%@ Page Title="Learn Money. Build Wealth. Secure Your Future." Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="P2RLS._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- HERO SECTION -->
    <section class="hero-section-landing">
        <div class="container">
            <div class="row align-items-center g-5">
                <!-- Left Column: Copy & CTAs -->
                <div class="col-lg-6">
                    <div class="badge-empower">
                        <i class="bi bi-stars"></i> EMPOWERING NEXT GEN WEALTH
                    </div>
                    <h1 class="hero-title">
                        Learn Then Earn.<br />
                        <span class="gradient-text">Build Wealth.</span><br />
                        Secure Your Future.
                    </h1>
                    <p class="hero-subtitle">
                        The modern learning ecosystem for financial freedom. Master investing, credit, and asset management through interactive simulations and a gamified virtual economy.
                    </p>

                    <!-- Auth-Aware Action Buttons -->
                    <div class="d-flex flex-wrap gap-3 mb-4">
                        <asp:PlaceHolder ID="phGuestCta" runat="server">
                            <a class="btn btn-brand btn-lg d-inline-flex align-items-center gap-2" href="~/Pages/User/Register.aspx" runat="server">
                                Start Learning Now <i class="bi bi-arrow-right"></i>
                            </a>
                            <a class="btn btn-outline-brand btn-lg" href="~/Pages/User/Simulations.aspx" runat="server">
                                View Simulations
                            </a>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phMemberCta" runat="server" Visible="false">
                            <a class="btn btn-brand btn-lg d-inline-flex align-items-center gap-2" href="~/Pages/User/Dashboard.aspx" runat="server">
                                Go to Dashboard <i class="bi bi-speedometer2"></i>
                            </a>
                            <a class="btn btn-outline-brand btn-lg" href="~/Pages/User/Lessons.aspx" runat="server">
                                Continue Academy
                            </a>
                        </asp:PlaceHolder>
                    </div>

                    <!-- Highlights -->
                    <div class="d-flex align-items-center gap-3 pt-2 text-muted small">
                        <span><i class="bi bi-check-circle-fill text-success me-1"></i> Structured 6-Level Path</span>
                        <span><i class="bi bi-check-circle-fill text-success me-1"></i> Interactive Simulations</span>
                        <span><i class="bi bi-check-circle-fill text-success me-1"></i> 100% Risk-Free</span>
                    </div>
                </div>

                <!-- Right Column: Interactive Floating Cards & Glow -->
                <div class="col-lg-6">
                    <div class="hero-mockups-container">
                        <div class="hero-glow-bg"></div>

                        <!-- Mockup Card 1: Stock Market -->
                        <div class="floating-card floating-card-1">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="unit-icon-box">
                                        <i class="bi bi-graph-up-arrow"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">Stock Market</div>
                                        <div class="text-muted small">Simulation v1.2</div>
                                    </div>
                                </div>
                                <span class="badge bg-success bg-opacity-10 text-success fw-bold px-2 py-1">+14.2%</span>
                            </div>
                            <div class="progress mt-2" style="height: 6px;">
                                <div class="progress-bar" style="width: 75%;"></div>
                            </div>
                        </div>

                        <!-- Mockup Card 2: Portfolio Diversity -->
                        <div class="floating-card floating-card-2">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="unit-icon-box" style="background:#E0F2FE; color:#0284C7;">
                                        <i class="bi bi-pie-chart-fill"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">Portfolio</div>
                                        <div class="text-muted small">Asset Diversity</div>
                                    </div>
                                </div>
                                <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-2 py-1">Balanced</span>
                            </div>
                            <div class="progress mt-2" style="height: 6px;">
                                <div class="progress-bar" style="width: 60%; background: linear-gradient(90deg, #0284C7, #7C3AED);"></div>
                            </div>
                        </div>

                        <!-- Mockup Card 3: Financial Health Score -->
                        <div class="floating-card floating-card-3">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="unit-icon-box" style="background:#FCE7F3; color:#DB2777;">
                                        <i class="bi bi-shield-check"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">Financial Health Score</div>
                                        <div class="text-muted small">Credit &amp; Savings Profile</div>
                                    </div>
                                </div>
                                <div class="fs-4 fw-extrabold text-primary">820</div>
                            </div>
                            <div class="progress" style="height: 10px;">
                                <div class="progress-bar" style="width: 82%; background: linear-gradient(90deg, #7C3AED, #C026D3);"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- SECTION 2: TOOLS FOR TRANSFORMATION -->
    <section class="section-tools">
        <div class="container">
            <!-- Section Header -->
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-5 gap-3">
                <div>
                    <h2 class="section-title mb-2">Tools for Transformation</h2>
                    <p class="section-subtitle mb-0">P2RLS combines academic rigor with game mechanics to make wealth building second nature.</p>
                </div>
                <a href="~/Pages/User/Lessons.aspx" class="see-all-link" runat="server">
                    See all features <i class="bi bi-arrow-right"></i>
                </a>
            </div>

            <!-- Bento Grid -->
            <div class="row g-4">
                <!-- Bento Card 1: Interactive Financial Lessons (2 cols) -->
                <div class="col-lg-7">
                    <div class="bento-card d-flex flex-column justify-content-between">
                        <div>
                            <span class="badge-brand mb-3">ACADEMY</span>
                            <h3 class="h4 fw-bold text-dark mb-3">Interactive Financial Lessons</h3>
                            <p class="text-muted mb-4">
                                Master concepts like compound interest, crypto-assets, and tax optimization through bite-sized, tactile lessons that stick.
                            </p>
                        </div>
                        
                        <!-- Unit Preview Elements -->
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <div class="mini-unit-card">
                                    <div class="unit-icon-box">
                                        <i class="bi bi-journal-text"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold small text-dark">UNIT 1: Survival</div>
                                        <div class="progress mt-2" style="height: 4px;">
                                            <div class="progress-bar" style="width: 100%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="mini-unit-card">
                                    <div class="unit-icon-box unit-icon-box-purple">
                                        <i class="bi bi-bullseye"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold small text-dark">UNIT 2: Saver</div>
                                        <div class="progress mt-2" style="height: 4px;">
                                            <div class="progress-bar" style="width: 40%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bento Card 2: Risk-Free Sandbox (Right tall card) -->
                <div class="col-lg-5">
                    <div class="sandbox-dark-card">
                        <div>
                            <div class="sandbox-icon-wrap">
                                <i class="bi bi-controller"></i>
                            </div>
                            <h3 class="h4 fw-bold text-white mb-3">Risk-Free Sandbox</h3>
                            <p class="text-light opacity-75 mb-4">
                                Trade stocks, manage a portfolio, and test virtual strategies using real-time market simulation without losing a single dime.
                            </p>
                        </div>
                        <div>
                            <a href="~/Pages/User/Simulations.aspx" class="btn btn-light rounded-pill px-4 py-2 fw-bold text-dark" runat="server">
                                Try Now <i class="bi bi-play-fill ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Bento Card 3: Level Up Your Knowledge -->
                <div class="col-lg-6">
                    <div class="bento-card">
                        <h3 class="h5 fw-bold text-dark mb-2">Level Up Your Knowledge</h3>
                        <p class="text-muted small mb-4">
                            Turn your financial journey into an RPG. Earn XP, unlock rare achievements, and climb the leaderboard as you level up.
                        </p>
                        
                        <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-4 border border-light">
                            <div class="icon-box-purple rounded-circle" style="width: 44px; height: 44px;">
                                <i class="bi bi-trophy-fill fs-5"></i>
                            </div>
                            <div class="flex-grow-1">
                                <div class="d-flex justify-content-between small fw-bold mb-1">
                                    <span>Beginner to Genius</span>
                                    <span class="text-primary">45%</span>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar" style="width: 45%;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bento Card 4: Virtual Economy & Store -->
                <div class="col-lg-6">
                    <div class="bento-card d-flex justify-content-between flex-column" style="background: linear-gradient(135deg, #FFFFFF 0%, #FFFBEB 100%);">
                        <div>
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h3 class="h5 fw-bold text-dark mb-2">Virtual Economy &amp; Store</h3>
                                <div class="reward-icon-circle" style="width: 44px; height: 44px; background: #FEF3C7; color: #B45309;">
                                    <i class="bi bi-shop fs-5"></i>
                                </div>
                            </div>
                            <p class="text-muted small mb-3">
                                Earn virtual coins by mastering lessons and making smart financial decisions. Trade items, unlock avatar titles, and build your digital wealth.
                            </p>
                        </div>

                        <div class="pt-2 d-flex flex-wrap gap-1">
                            <a href="~/Pages/User/RewardShop.aspx" class="reward-tag" runat="server"><i class="bi bi-bag-check-fill me-1"></i>Reward Store</a>
                            <a href="~/Pages/User/Wallet.aspx" class="reward-tag" runat="server"><i class="bi bi-coin me-1"></i>Virtual Coins</a>
                            <a href="~/Pages/User/Wallet.aspx" class="reward-tag" runat="server"><i class="bi bi-graph-up me-1"></i>Asset Portfolio</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- SECTION 3: YOUR JOURNEY TO WEALTH (6-Level Stepper) -->
    <section class="section-journey">
        <div class="container">
            <div class="text-center max-w-700 mx-auto mb-5">
                <h2 class="section-title mb-2">Your Journey to Wealth</h2>
                <p class="section-subtitle">
                    From Financial Novice to Master Wealth Builder. Our 6-level structured curriculum guides you every step of the way.
                </p>
            </div>

            <!-- 6 Step Stepper Grid -->
            <div class="row g-3 justify-content-center journey-stepper-container">
                <!-- Step 1: Novice -->
                <div class="col-lg-2 col-md-4 col-sm-6 journey-step-col">
                    <div class="journey-step-card">
                        <div class="step-num-badge active-badge">1</div>
                        <div class="step-name">NOVICE</div>
                        <p class="step-desc">Budgeting &amp; Fundamental Basics</p>
                    </div>
                </div>

                <!-- Step 2: Squire -->
                <div class="col-lg-2 col-md-4 col-sm-6 journey-step-col">
                    <div class="journey-step-card">
                        <div class="step-num-badge">2</div>
                        <div class="step-name">SQUIRE</div>
                        <p class="step-desc">Credit Mastery &amp; Score Building</p>
                    </div>
                </div>

                <!-- Step 3: Trader -->
                <div class="col-lg-2 col-md-4 col-sm-6 journey-step-col">
                    <div class="journey-step-card">
                        <div class="step-num-badge">3</div>
                        <div class="step-name">TRADER</div>
                        <p class="step-desc">Investment Logic &amp; Risk Profiles</p>
                    </div>
                </div>

                <!-- Step 4: Strategist -->
                <div class="col-lg-2 col-md-4 col-sm-6 journey-step-col">
                    <div class="journey-step-card">
                        <div class="step-num-badge">4</div>
                        <div class="step-name">STRATEGIST</div>
                        <p class="step-desc">Tax Efficiency &amp; Equity Growth</p>
                    </div>
                </div>

                <!-- Step 5: Tycoon -->
                <div class="col-lg-2 col-md-4 col-sm-6 journey-step-col">
                    <div class="journey-step-card">
                        <div class="step-num-badge">5</div>
                        <div class="step-name">TYCOON</div>
                        <p class="step-desc">Real Estate &amp; Crypto Management</p>
                    </div>
                </div>

                <!-- Step 6: Master (Featured Highlight) -->
                <div class="col-lg-2 col-md-4 col-sm-6 journey-step-col">
                    <div class="journey-step-card featured-step">
                        <div class="step-num-badge master-badge">6</div>
                        <div class="step-name text-primary">MASTER</div>
                        <p class="step-desc">Legacy Building &amp; Generational Wealth</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- SECTION 4: DARK CTA BANNER -->
    <section class="section-cta-banner">
        <div class="container">
            <div class="cta-banner-dark">
                <h2 class="cta-title">Ready to Change Your Financial Future?</h2>
                <p class="cta-subtitle">
                    Start your structured journey from financial survival to wealth building. Explore interactive lessons and real decision simulations today.
                </p>

                <div class="d-flex flex-wrap justify-content-center gap-3 mb-2">
                    <asp:PlaceHolder ID="phGuestCta2" runat="server">
                        <a href="~/Pages/User/Register.aspx" class="btn btn-cta-primary" runat="server">Create Free Account</a>
                        <a href="~/Pages/User/Lessons.aspx" class="btn btn-cta-secondary" runat="server">Explore Curriculum</a>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="phMemberCta2" runat="server" Visible="false">
                        <a href="~/Pages/User/Dashboard.aspx" class="btn btn-cta-primary" runat="server">Go to Dashboard</a>
                        <a href="~/Pages/User/Lessons.aspx" class="btn btn-cta-secondary" runat="server">Explore Curriculum</a>
                    </asp:PlaceHolder>
                </div>

                <p class="text-muted small mt-3 mb-0">No credit card required. Cancel anytime.</p>
            </div>
        </div>
    </section>
</asp:Content>

