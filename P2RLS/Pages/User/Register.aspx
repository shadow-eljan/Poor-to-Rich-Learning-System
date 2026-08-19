<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="P2RLS.Pages.User.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-page-wrapper">
        <div class="auth-card">
            <div class="row g-0">
                <!-- Left Brand Panel (Galaxy Purple) -->
                <div class="col-lg-5 auth-brand-panel">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-4">
                            <span class="brand-logo-badge">P2</span>
                            <span class="brand-text text-white">P2RLS</span>
                        </div>
                        <h2>Empower Your Financial Future.</h2>
                        <p>
                            Master the art of financial literacy through gamified simulations and structured learning modules.
                        </p>
                    </div>

                    <div class="auth-mini-highlight d-flex align-items-center gap-3">
                        <div class="unit-icon-box" style="background: rgba(255,255,255,0.2); color:#FFFFFF;">
                            <i class="bi bi-shield-check fs-5"></i>
                        </div>
                        <div>
                            <div class="fw-bold small text-white">Structured Learning</div>
                            <div class="text-white opacity-75 small">6 levels from novice to wealth master</div>
                        </div>
                    </div>
                </div>

                <!-- Right Form Panel -->
                <div class="col-lg-7 auth-form-panel">
                    <h1>Create Account</h1>
                    <p class="form-subtitle">Start your journey toward financial mastery.</p>

                    <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-3" DisplayMode="BulletList" />
                    <asp:Literal ID="litServerError" runat="server" />

                    <div class="mb-3">
                        <label for="<%= txtUsername.ClientID %>" class="form-label fw-semibold small text-muted">Username</label>
                        <div class="input-icon-group">
                            <i class="bi bi-person input-icon"></i>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a username" MaxLength="50" autocomplete="username" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                            ErrorMessage="Username is required." CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revUsername" runat="server" ControlToValidate="txtUsername"
                            ValidationExpression="^[a-zA-Z0-9_]{3,50}$"
                            ErrorMessage="3-50 characters: letters, numbers, underscore only."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <label for="<%= txtEmail.ClientID %>" class="form-label fw-semibold small text-muted">Email Address</label>
                        <div class="input-icon-group">
                            <i class="bi bi-envelope input-icon"></i>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="name@example.com" autocomplete="email" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email is required." CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Enter a valid email address." CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <label for="<%= txtPassword.ClientID %>" class="form-label fw-semibold small text-muted">Password</label>
                        <div class="input-icon-group">
                            <i class="bi bi-lock input-icon"></i>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a strong password" autocomplete="new-password" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password is required." CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                            ValidationExpression="^(?=.*[A-Za-z])(?=.*\d).{8,100}$"
                            ErrorMessage="At least 8 characters, with a letter and a number."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-4">
                        <label for="<%= txtConfirmPassword.ClientID %>" class="form-label fw-semibold small text-muted">Confirm Password</label>
                        <div class="input-icon-group">
                            <i class="bi bi-shield-lock input-icon"></i>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Re-enter your password" autocomplete="new-password" />
                        </div>
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword" ErrorMessage="Passwords do not match."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-auth-submit mb-3" OnClick="btnRegister_Click" />

                    <div class="text-center pt-2">
                        <span class="text-muted small">Already have an account?</span>
                        <a href="~/Pages/User/Login.aspx" class="fw-bold text-primary small ms-1" runat="server">Log in</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

