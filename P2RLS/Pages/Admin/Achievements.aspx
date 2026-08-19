<%@ Page Title="Achievements" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Achievements.aspx.cs" Inherits="P2RLS.Pages.Admin.Achievements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Top Bar -->
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
            <div>
                <a class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-2" href="~/Pages/Admin/Dashboard.aspx" runat="server">
                    &larr; Admin Control Center
                </a>
                <h1 class="h3 fw-bold text-dark mb-0">Platform Milestone Achievements</h1>
            </div>
            <a class="btn btn-brand rounded-pill px-4 py-2 fw-semibold" href="~/Pages/Admin/AchievementEdit.aspx" runat="server">
                + New Achievement
            </a>
        </div>

        <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="row mb-4">
                <div class="col-md-5">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control rounded-start-pill ps-3" placeholder="Search achievements..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-brand rounded-end-pill px-4" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <asp:Literal ID="litEmpty" runat="server" />

            <div class="table-responsive">
                <asp:GridView ID="gvAchievements" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false" DataKeyNames="id"
                    AllowSorting="true" OnSorting="gvAchievements_Sorting"
                    AllowCustomPaging="true" AllowPaging="true" PageSize="10"
                    OnPageIndexChanging="gvAchievements_PageIndexChanging"
                    OnRowCommand="gvAchievements_RowCommand">
                    <HeaderStyle CssClass="table-light text-muted small fw-bold" />
                    <Columns>
                        <asp:BoundField DataField="name" HeaderText="Achievement Title" SortExpression="name" ItemStyle-CssClass="fw-bold text-dark" />
                        <asp:BoundField DataField="condition_type" HeaderText="Trigger Condition" ItemStyle-CssClass="text-primary fw-semibold" />
                        <asp:BoundField DataField="condition_value" HeaderText="Target Goal" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="reward_coins" HeaderText="Coin Reward" ItemStyle-CssClass="fw-bold text-warning" />
                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <a class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1" href='<%# "~/Pages/Admin/AchievementEdit.aspx?id=" + Eval("id") %>' runat="server">Edit</a>
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                    CommandName="DeleteAchievement" CommandArgument='<%# Eval("id") %>'
                                    data-confirm="Delete this achievement badge? Users who unlocked it will retain their stats."
                                    data-confirm-title="Delete Achievement">
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

