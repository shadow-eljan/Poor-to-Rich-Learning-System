<%@ Page Title="Login" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="P2RLS.Pages.User.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-page-wrapper">
        <div class="auth-card">
            <div class="row g-0">
                <!-- Left Form Panel -->
                <div class="col-lg-6 auth-form-panel">
                    <h1>Welcome back</h1>
                    <p class="form-subtitle">Please enter your details to sign in to P2RLS.</p>

                    <asp:Literal ID="litRegisteredMsg" runat="server" />
                    <asp:Literal ID="litServerError" runat="server" />
                    <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-3" DisplayMode="BulletList" />

                    <div class="mb-3">
                        <label for="<%= txtUsername.ClientID %>" class="form-label fw-semibold small text-muted">Username</label>
                        <div class="input-icon-group">
                            <i class="bi bi-person input-icon"></i>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" autocomplete="username" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                            ErrorMessage="Username is required." CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-4">
                        <label for="<%= txtPassword.ClientID %>" class="form-label fw-semibold small text-muted">Password</label>
                        <div class="input-icon-group">
                            <i class="bi bi-lock input-icon"></i>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password" autocomplete="current-password" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password is required." CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Login to Account" CssClass="btn-auth-submit mb-3" OnClick="btnLogin_Click" />

                    <div class="text-center pt-2">
                        <span class="text-muted small">Don't have an account?</span>
                        <a href="~/Pages/User/Register.aspx" class="fw-bold text-primary small ms-1" runat="server">Register now</a>
                    </div>
                </div>

                <!-- Right Brand Panel (Galaxy Purple) -->
                <div class="col-lg-6 auth-brand-panel">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-4">
                            <span class="brand-logo-badge">P2</span>
                            <span class="brand-text text-white">P2RLS</span>
                        </div>
                        <h2>Master your financial future today.</h2>
                        <p>
                            Step into an interactive learning ecosystem designed to guide you from financial basics to long-term wealth building.
                        </p>
                    </div>

                    <div class="row g-2 mt-4">
                        <div class="col-6">
                            <div class="auth-mini-highlight m-0 p-3 h-100">
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <i class="bi bi-mortarboard-fill text-warning"></i>
                                    <span class="fw-bold text-white small">STRUCTURED</span>
                                </div>
                                <div class="text-white opacity-75 small" style="font-size:0.78rem;">6-level progressive curriculum</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="auth-mini-highlight m-0 p-3 h-100">
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <i class="bi bi-controller text-info"></i>
                                    <span class="fw-bold text-white small">SANDBOX</span>
                                </div>
                                <div class="text-white opacity-75 small" style="font-size:0.78rem;">Zero-risk decision simulations</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

