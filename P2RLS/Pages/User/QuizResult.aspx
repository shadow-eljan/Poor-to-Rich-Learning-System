<%@ Page Title="Quiz Result" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="QuizResult.aspx.cs" Inherits="P2RLS.Pages.User.QuizResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 max-w-700 mx-auto">
        <div class="card p-4 p-md-5 border-0 shadow text-center" style="border-radius: 24px; background: #FFFFFF;">
            <!-- Trophy / Badge Icon -->
            <div class="mx-auto mb-3 d-flex align-items-center justify-content-center text-white rounded-circle shadow" 
                 id="pnlIcon" runat="server"
                 style="width: 84px; height: 84px; font-size: 2.5rem; background: linear-gradient(135deg, #7C3AED, #C026D3);">
                <asp:Literal ID="litIcon" runat="server" Text="🏆" />
            </div>

            <h1 class="h2 fw-bold text-dark mb-1"><asp:Literal ID="litStatusTitle" runat="server" Text="Quiz Complete!" /></h1>
            <p class="text-muted mb-4"><asp:Literal ID="litStatusSubtitle" runat="server" /></p>

            <asp:Literal ID="litAchievements" runat="server" />

            <!-- Score Pill -->
            <div class="p-4 rounded-4 mb-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                <div class="display-4 fw-extrabold mb-1" id="scoreWrapper" runat="server">
                    <asp:Literal ID="litScore" runat="server" />%
                </div>
                <div class="text-muted fw-semibold">
                    <asp:Literal ID="litCorrect" runat="server" /> correct out of <asp:Literal ID="litTotal" runat="server" /> questions
                </div>

                <div class="d-flex justify-content-center gap-3 mt-3 pt-3 border-top">
                    <span class="badge bg-warning bg-opacity-20 text-dark fw-bold px-3 py-2 rounded-pill">
                        🪙 +<asp:Literal ID="litCoins" runat="server" /> Coins
                    </span>
                    <span class="badge bg-primary bg-opacity-20 text-primary fw-bold px-3 py-2 rounded-pill">
                        🎓 Tier Level <asp:Literal ID="litLevel" runat="server" />
                    </span>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex flex-column flex-sm-row justify-content-center gap-3">
                <a id="lnkNextLesson" runat="server" class="btn btn-brand px-4 py-2 fw-bold d-inline-flex align-items-center justify-content-center gap-2">
                    Next Lesson <i class="bi bi-arrow-right"></i>
                </a>
                <a id="lnkRetake" runat="server" class="btn btn-outline-secondary px-4 py-2 fw-semibold" visible="false">
                    <i class="bi bi-arrow-repeat me-1"></i> Retake Quiz
                </a>
                <a class="btn btn-outline-brand px-4 py-2 fw-semibold" href="~/Pages/User/Lessons.aspx" runat="server">
                    All Lessons
                </a>
            </div>
        </div>
    </div>
</asp:Content>

