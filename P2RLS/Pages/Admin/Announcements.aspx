<%@ Page Title="Announcements" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="P2RLS.Pages.Admin.Announcements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Top Bar -->
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
            <div>
                <a class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-2" href="~/Pages/Admin/Dashboard.aspx" runat="server">
                    &larr; Admin Control Center
                </a>
                <h1 class="h3 fw-bold text-dark mb-0">Platform Announcements</h1>
            </div>
            <a class="btn btn-brand rounded-pill px-4 py-2 fw-semibold" href="~/Pages/Admin/AnnouncementEdit.aspx" runat="server">
                + New Announcement
            </a>
        </div>

        <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="row mb-4">
                <div class="col-md-5">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control rounded-start-pill ps-3" placeholder="Search announcements..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-brand rounded-end-pill px-4" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <asp:Literal ID="litEmpty" runat="server" />

            <div class="table-responsive">
                <asp:GridView ID="gvAnnouncements" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false" DataKeyNames="id"
                    AllowSorting="true" OnSorting="gvAnnouncements_Sorting"
                    AllowCustomPaging="true" AllowPaging="true" PageSize="10"
                    OnPageIndexChanging="gvAnnouncements_PageIndexChanging"
                    OnRowCommand="gvAnnouncements_RowCommand">
                    <HeaderStyle CssClass="table-light text-muted small fw-bold" />
                    <Columns>
                        <asp:BoundField DataField="title" HeaderText="Announcement Title" SortExpression="title" ItemStyle-CssClass="fw-bold text-dark" />
                        <asp:BoundField DataField="posted_by_username" HeaderText="Author" ItemStyle-CssClass="text-primary fw-semibold" />
                        <asp:BoundField DataField="posted_at" HeaderText="Date Posted" SortExpression="posted_at" DataFormatString="{0:MMM d, yyyy}" ItemStyle-CssClass="text-muted" />
                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <a class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1" href='<%# "~/Pages/Admin/AnnouncementEdit.aspx?id=" + Eval("id") %>' runat="server">Edit</a>
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                    CommandName="DeleteAnnouncement" CommandArgument='<%# Eval("id") %>'
                                    data-confirm="Delete this announcement? It will be removed from all users' feeds."
                                    data-confirm-title="Delete Announcement">
                                    Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

