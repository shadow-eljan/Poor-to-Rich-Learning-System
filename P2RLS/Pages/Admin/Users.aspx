<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="P2RLS.Pages.Admin.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Top Bar -->
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
            <div>
                <a class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-2" href="~/Pages/Admin/Dashboard.aspx" runat="server">
                    &larr; Admin Control Center
                </a>
                <h1 class="h3 fw-bold text-dark mb-0">Platform User Directory</h1>
            </div>
        </div>

        <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="row mb-4">
                <div class="col-md-5">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control rounded-start-pill ps-3" placeholder="Search username or email..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-brand rounded-end-pill px-4" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <asp:Literal ID="litMessage" runat="server" />

            <div class="table-responsive">
                <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false" DataKeyNames="id"
                    AllowSorting="true" OnSorting="gvUsers_Sorting"
                    AllowCustomPaging="true" AllowPaging="true" PageSize="10"
                    OnPageIndexChanging="gvUsers_PageIndexChanging"
                    OnRowCommand="gvUsers_RowCommand">
                    <HeaderStyle CssClass="table-light text-muted small fw-bold" />
                    <Columns>
                        <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" ItemStyle-CssClass="fw-bold text-dark" />
                        <asp:BoundField DataField="email" HeaderText="Email Address" ItemStyle-CssClass="text-muted small" />
                        <asp:BoundField DataField="role" HeaderText="Role" ItemStyle-CssClass="fw-semibold text-primary" />
                        <asp:BoundField DataField="level" HeaderText="Level" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="virtual_coins" HeaderText="Coins" ItemStyle-CssClass="fw-bold text-warning" />
                        <asp:BoundField DataField="created_at" HeaderText="Registration Date" SortExpression="created_at" DataFormatString="{0:MMM d, yyyy}" ItemStyle-CssClass="text-muted small" />
                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkToggleRole" runat="server" CssClass="btn btn-sm btn-outline-primary rounded-pill px-3 me-1"
                                    CommandName="ToggleRole" CommandArgument='<%# Eval("id") + "|" + Eval("role") %>'>
                                    <%# (string)Eval("role") == "Admin" ? "Make Member" : "Make Admin" %>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                    CommandName="DeleteUser" CommandArgument='<%# Eval("id") %>'
                                    data-confirm="Delete this user? Their activity history must be clear first."
                                    data-confirm-title="Delete User">
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

