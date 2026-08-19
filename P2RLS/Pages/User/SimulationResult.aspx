<%@ Page Title="Simulation Result" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="SimulationResult.aspx.cs" Inherits="P2RLS.Pages.User.SimulationResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 max-w-700 mx-auto text-center">
        <asp:Literal ID="litAchievements" runat="server" />

        <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 24px; background: #FFFFFF;">
            <div class="icon-box mx-auto mb-3" style="width: 64px; height: 64px; border-radius: 18px; background: linear-gradient(135deg, #10B981, #059669); color: white; display: inline-flex; align-items: center; justify-content: center;">
                <i class="bi bi-award-fill fs-2"></i>
            </div>
            
            <span class="badge bg-success bg-opacity-10 text-success fw-bold px-3 py-1 rounded-pill mb-2" style="width: fit-content; margin: 0 auto;">
                SCENARIO RESOLVED
            </span>

            <h1 class="h3 fw-bold text-dark mb-4">Simulation Outcome</h1>

            <div class="p-3 rounded-4 mb-4 text-start" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                <div class="small text-muted fw-bold mb-1">YOUR DECISION</div>
                <div class="fw-bold text-dark fs-6 mb-3"><asp:Literal ID="litChoice" runat="server" /></div>

                <div class="small text-muted fw-bold mb-1">CONSEQUENCE & ANALYSIS</div>
                <div class="text-secondary" style="line-height: 1.6;"><asp:Literal ID="litOutcome" runat="server" /></div>
            </div>

            <!-- Rewards Badge -->
            <div class="d-flex justify-content-center gap-3 mb-4">
                <div class="badge bg-light text-dark border px-3 py-2 rounded-pill fw-bold">
                    +<asp:Literal ID="litExp" runat="server" /> EXP
                </div>
                <div class="badge bg-warning bg-opacity-20 text-dark border px-3 py-2 rounded-pill fw-bold">
                    🪙 +<asp:Literal ID="litCoins" runat="server" /> Coins
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3">
                <a class="btn btn-brand px-4 py-2 rounded-pill fw-bold" href="~/Pages/User/Simulations.aspx" runat="server">
                    Try Another Simulation &rarr;
                </a>
                <a class="btn btn-outline-secondary px-4 py-2 rounded-pill" href="~/Pages/User/Dashboard.aspx" runat="server">
                    Dashboard
                </a>
            </div>
        </div>
    </div>
</asp:Content>

