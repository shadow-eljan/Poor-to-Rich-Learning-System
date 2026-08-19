<%@ Page Title="Achievements" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Achievements.aspx.cs" Inherits="P2RLS.Pages.User.Achievements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Header -->
        <div class="mb-4">
            <h1 class="h2 fw-bold text-dark mb-1">Milestones & Achievements</h1>
            <p class="text-muted" style="max-width: 700px;">
                Earn prestigious badges and bonus virtual coins by mastering chapters, finishing simulations, and building your net worth.
            </p>
        </div>

        <div class="row g-4">
            <asp:Repeater ID="rptAchievements" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4">
                        <div class='<%# (int)Eval("is_earned") == 1 
                            ? "card h-100 border-0 shadow-sm p-4 d-flex flex-column" 
                            : "card h-100 border-0 shadow-sm p-4 d-flex flex-column opacity-75" %>'
                            style='<%# (int)Eval("is_earned") == 1 
                                ? "border-radius: 20px; background: #FFFFFF; border-top: 4px solid #10B981 !important;" 
                                : "border-radius: 20px; background: #F8FAFC; border-top: 4px solid #CBD5E1 !important;" %>'>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="icon-box" style='<%# (int)Eval("is_earned") == 1 
                                    ? "width: 44px; height: 44px; background: #DCFCE7; color: #15803D; border-radius: 12px; display: inline-flex; align-items: center; justify-content: center; font-size: 1.25rem;" 
                                    : "width: 44px; height: 44px; background: #E2E8F0; color: #64748B; border-radius: 12px; display: inline-flex; align-items: center; justify-content: center; font-size: 1.25rem;" %>'>
                                    🏆
                                </div>
                                <span class="badge bg-warning bg-opacity-20 text-dark fw-bold px-3 py-1 rounded-pill">
                                    🪙 +<%#: Eval("reward_coins") %> coins
                                </span>
                            </div>

                            <h2 class="h5 fw-bold text-dark mb-2"><%#: Eval("name") %></h2>
                            <p class="text-muted small mb-4 flex-grow-1" style="line-height: 1.5;"><%#: Eval("description") %></p>

                            <div class="pt-3 border-top mt-auto">
                                <%# (int)Eval("is_earned") == 1
                                    ? "<span class='badge bg-success bg-opacity-10 text-success fw-bold px-3 py-2 rounded-pill w-100'>&#10003; Unlocked on " + Convert.ToDateTime(Eval("earned_at")).ToString("MMM d, yyyy") + "</span>"
                                    : "<span class='badge bg-secondary bg-opacity-25 text-muted fw-bold px-3 py-2 rounded-pill w-100'>&#128274; Locked</span>" %>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

