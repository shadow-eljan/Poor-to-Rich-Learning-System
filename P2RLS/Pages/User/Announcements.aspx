<%@ Page Title="Announcements" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="P2RLS.Pages.User.Announcements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-900 mx-auto">
        <!-- Header -->
        <div class="mb-4">
            <h1 class="h2 fw-bold text-dark mb-1">Platform Announcements</h1>
            <p class="text-muted">Stay informed with curriculum updates, feature releases, and community news.</p>
        </div>

        <asp:Literal ID="litEmpty" runat="server" />

        <div class="d-flex flex-column gap-3">
            <asp:Repeater ID="rptAnnouncements" runat="server">
                <ItemTemplate>
                    <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h2 class="h5 fw-bold text-dark mb-0"><%#: Eval("title") %></h2>
                            <span class="badge bg-light text-muted border px-3 py-1 rounded-pill small">
                                <%#: Convert.ToDateTime(Eval("posted_at")).ToString("MMM d, yyyy") %>
                            </span>
                        </div>
                        <div class="text-muted small mb-3">
                            <i class="bi bi-person-circle text-primary me-1"></i> Posted by <%#: Eval("posted_by_username") %>
                        </div>
                        <p class="card-text text-secondary mb-0" style="line-height: 1.6;"><%#: Eval("content") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

