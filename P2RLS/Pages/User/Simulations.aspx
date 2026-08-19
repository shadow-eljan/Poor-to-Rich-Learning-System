<%@ Page Title="Simulations" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Simulations.aspx.cs" Inherits="P2RLS.Pages.User.Simulations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Header -->
        <div class="mb-4">
            <h1 class="h2 fw-bold text-dark mb-1">Financial Simulations</h1>
            <p class="text-muted" style="max-width: 700px;">
                Experience real-world financial dilemmas and market scenarios in a risk-free simulator. Test your choices before making them in real life.
            </p>
        </div>

        <div class="row g-4">
            <asp:Repeater ID="rptSimulations" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 border-0 shadow-sm p-4 d-flex flex-column" style="border-radius: 20px; background: #FFFFFF;">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-1 rounded-pill" style="font-size: 0.75rem;">
                                    LEVEL <%#: Eval("level_number") %>
                                </span>
                                <div class="icon-box" style="width: 36px; height: 36px; background: #F5F3FF; color: #7C3AED; border-radius: 10px; display: inline-flex; align-items: center; justify-content: center;">
                                    <i class="bi bi-controller"></i>
                                </div>
                            </div>
                            <h2 class="h5 fw-bold text-dark mb-2"><%#: Eval("title") %></h2>
                            <p class="card-text text-muted small mb-4 flex-grow-1" style="line-height: 1.5;"><%#: Eval("description") %></p>
                            <div class="pt-3 border-top mt-auto">
                                <a class="btn btn-brand w-100 rounded-pill fw-semibold" href='<%#: ResolveUrl("~/Pages/User/SimulationTake.aspx?id=" + Eval("id")) %>'>
                                    Launch Scenario &rarr;
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

