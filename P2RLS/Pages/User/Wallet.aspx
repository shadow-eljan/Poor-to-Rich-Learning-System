<%@ Page Title="Wallet" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Wallet.aspx.cs" Inherits="P2RLS.Pages.User.Wallet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Header -->
        <div class="mb-4">
            <h1 class="h2 fw-bold text-dark mb-1">My Virtual Wallet</h1>
            <p class="text-muted" style="max-width: 700px;">
                Practice saving, allocating assets, and managing market risk &mdash; 100% risk-free with virtual coins.
            </p>
        </div>

        <asp:Literal ID="litMessage" runat="server" />

        <!-- Balance Highlights -->
        <div class="row g-4 mb-4">
            <div class="col-md-6 col-lg-4">
                <div class="card p-4 border-0 shadow-sm text-center" style="border-radius: 20px; background: linear-gradient(135deg, #FEF3C7 0%, #FFFFFF 100%);">
                    <div class="icon-box mx-auto mb-2" style="background: #FDE68A; color: #B45309;">
                        <i class="bi bi-cash-coin fs-4"></i>
                    </div>
                    <div class="fs-2 fw-bold text-dark mb-1"><asp:Literal ID="litCash" runat="server" /></div>
                    <div class="text-muted fw-semibold small">Cash Available (Keep)</div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card p-4 border-0 shadow-sm text-center" style="border-radius: 20px; background: linear-gradient(135deg, #DCFCE7 0%, #FFFFFF 100%);">
                    <div class="icon-box mx-auto mb-2" style="background: #BBF7D0; color: #15803D;">
                        <i class="bi bi-piggy-bank-fill fs-4"></i>
                    </div>
                    <div class="fs-2 fw-bold text-dark mb-1"><asp:Literal ID="litSavings" runat="server" /></div>
                    <div class="text-muted fw-semibold small">Savings Reserve</div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card p-4 border-0 shadow-sm h-100 d-flex justify-content-center" style="border-radius: 20px; background: #F8FAFC;">
                    <div class="d-flex align-items-center gap-2 mb-2 text-primary fw-bold small">
                        <i class="bi bi-info-circle-fill"></i> Financial Wisdom
                    </div>
                    <p class="text-muted small mb-0" style="line-height: 1.5;">
                        Coins left idle as cash earn zero return. Savings build safety, while investing builds long-term equity.
                    </p>
                </div>
            </div>
        </div>

        <!-- Operations & Activity Grid -->
        <div class="row g-4">
            <!-- 1. Savings Management -->
            <div class="col-lg-4">
                <div class="card p-4 border-0 shadow-sm h-100" style="border-radius: 20px; background: #FFFFFF;">
                    <h2 class="h5 fw-bold text-dark mb-3"><i class="bi bi-safe-fill text-success me-2"></i>Savings Vault</h2>
                    
                    <div class="mb-3">
                        <label class="form-label small text-muted fw-semibold">Deposit into Savings</label>
                        <asp:TextBox ID="txtDepositAmount" runat="server" CssClass="form-control mb-2" TextMode="Number" placeholder="Amount to deposit" />
                        <asp:Button ID="btnDeposit" runat="server" Text="Deposit Coins" CssClass="btn btn-brand w-100" OnClick="btnDeposit_Click" />
                    </div>

                    <div class="pt-3 border-top">
                        <label class="form-label small text-muted fw-semibold">Withdraw to Cash</label>
                        <asp:TextBox ID="txtWithdrawAmount" runat="server" CssClass="form-control mb-2" TextMode="Number" placeholder="Amount to withdraw" />
                        <asp:Button ID="btnWithdraw" runat="server" Text="Withdraw" CssClass="btn btn-outline-secondary w-100" OnClick="btnWithdraw_Click" />
                    </div>
                </div>
            </div>

            <!-- 2. Invest Section -->
            <div class="col-lg-4">
                <div class="card p-4 border-0 shadow-sm h-100" style="border-radius: 20px; background: #FFFFFF;">
                    <h2 class="h5 fw-bold text-dark mb-3"><i class="bi bi-graph-up-arrow text-primary me-2"></i>Asset Investment</h2>
                    
                    <div class="mb-3">
                        <label class="form-label small text-muted fw-semibold">Select Asset Class</label>
                        <asp:DropDownList ID="ddlAssetType" runat="server" CssClass="form-select mb-3">
                            <asp:ListItem Text="Bonds (Low risk)" Value="Bonds" />
                            <asp:ListItem Text="Mutual Funds (Medium risk)" Value="Mutual Funds" />
                            <asp:ListItem Text="Stocks (High risk)" Value="Stocks" />
                            <asp:ListItem Text="Business (Very high risk)" Value="Business" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small text-muted fw-semibold">Investment Amount (Coins)</label>
                        <asp:TextBox ID="txtInvestAmount" runat="server" CssClass="form-control mb-3" TextMode="Number" placeholder="e.g. 50" />
                    </div>

                    <asp:Button ID="btnInvest" runat="server" Text="Confirm Investment" CssClass="btn btn-brand w-100" OnClick="btnInvest_Click" />
                </div>
            </div>

            <!-- 3. Recent Activity -->
            <div class="col-lg-4">
                <div class="card p-4 border-0 shadow-sm h-100" style="border-radius: 20px; background: #FFFFFF;">
                    <h2 class="h5 fw-bold text-dark mb-3"><i class="bi bi-clock-history text-secondary me-2"></i>Transaction Ledger</h2>
                    
                    <div class="list-group list-group-flush">
                        <asp:Repeater ID="rptHistory" runat="server">
                            <ItemTemplate>
                                <div class="list-group-item px-0 py-2 d-flex justify-content-between align-items-center border-bottom small">
                                    <div>
                                        <span class="fw-bold text-dark"><%#: Eval("type") %></span>
                                        <span class="text-muted d-block" style="font-size:0.75rem;"><%#: Eval("asset_type") %></span>
                                    </div>
                                    <span class="badge bg-light text-dark border fw-bold px-2 py-1">
                                        <%#: Eval("amount") %> coins
                                    </span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

