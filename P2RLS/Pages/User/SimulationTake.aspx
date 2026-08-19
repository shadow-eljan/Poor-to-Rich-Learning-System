<%@ Page Title="Simulation" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="SimulationTake.aspx.cs" Inherits="P2RLS.Pages.User.SimulationTake" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-800 mx-auto">
        <a class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-3" href="~/Pages/User/Simulations.aspx" runat="server">
            &larr; Back to Simulations
        </a>

        <div class="card p-4 p-md-5 mb-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <span class="badge badge-brand text-uppercase px-3 py-1 mb-2 rounded-pill fw-bold" style="font-size: 0.72rem; width: fit-content;">
                INTERACTIVE SCENARIO
            </span>
            <h1 class="h3 fw-bold text-dark mb-3"><asp:Literal ID="litTitle" runat="server" /></h1>
            <p class="lead text-muted fs-6 mb-4" style="line-height: 1.6;"><asp:Literal ID="litDescription" runat="server" /></p>

            <asp:Literal ID="litMessage" runat="server" />

            <h2 class="h6 fw-bold text-dark text-uppercase mb-3" style="letter-spacing: 0.5px;">What action will you take?</h2>
            
            <div class="d-flex flex-column gap-3">
                <asp:Repeater ID="rptChoices" runat="server" OnItemCommand="rptChoices_ItemCommand">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CssClass="card p-3 border-1 text-start text-decoration-none shadow-sm transition-all"
                            style="border-radius: 14px; background: #F8FAFC; border-color: #E2E8F0;"
                            CommandName="Choose" CommandArgument='<%# Container.ItemIndex %>'>
                            <div class="d-flex align-items-center gap-3">
                                <span class="badge bg-white text-primary border shadow-sm px-3 py-2 rounded-3 fw-bold">
                                    Option <%# (char)('A' + Container.ItemIndex) %>
                                </span>
                                <span class="fw-semibold text-dark fs-6">
                                    <%#: Eval("Choice") %>
                                </span>
                            </div>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>

