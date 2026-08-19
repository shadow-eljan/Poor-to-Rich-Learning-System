<%@ Page Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="AchievementEdit.aspx.cs" Inherits="P2RLS.Pages.Admin.AchievementEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-700 mx-auto">
        <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><asp:Literal ID="litHeading" runat="server" Text="New Achievement" /></h1>
                    <p class="text-muted small mb-0">Configure gamification milestones and coin rewards.</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="~/Pages/Admin/Achievements.aspx" runat="server">
                    &larr; Back to Achievements
                </a>
            </div>

            <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-4" DisplayMode="BulletList" />

            <div class="mb-3">
                <label for="<%= txtName.ClientID %>" class="form-label fw-bold small text-dark">Achievement Title</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="100" placeholder="e.g. Master Strategist" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label for="<%= txtDescription.ClientID %>" class="form-label fw-bold small text-dark">Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" 
                    placeholder="e.g. Complete 5 interactive scenario simulations." />
            </div>

            <div class="mb-3">
                <label for="<%= txtRewardCoins.ClientID %>" class="form-label fw-bold small text-dark">Reward Coins</label>
                <asp:TextBox ID="txtRewardCoins" runat="server" CssClass="form-control" TextMode="Number" style="max-width: 200px;" placeholder="50" />
                <asp:RequiredFieldValidator ID="rfvCoins" runat="server" ControlToValidate="txtRewardCoins"
                    ErrorMessage="Reward coins is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label for="<%= ddlConditionType.ClientID %>" class="form-label fw-bold small text-dark">Unlock Condition</label>
                <asp:DropDownList ID="ddlConditionType" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Quizzes Completed" Value="QuizzesCompleted" />
                    <asp:ListItem Text="Simulations Completed" Value="SimulationsCompleted" />
                    <asp:ListItem Text="Items Purchased" Value="ItemsPurchased" />
                    <asp:ListItem Text="Level Reached" Value="LevelReached" />
                </asp:DropDownList>
            </div>

            <div class="mb-4">
                <label for="<%= txtConditionValue.ClientID %>" class="form-label fw-bold small text-dark">Threshold Count / Target</label>
                <asp:TextBox ID="txtConditionValue" runat="server" CssClass="form-control" TextMode="Number" style="max-width: 200px;" placeholder="5" />
                <asp:RequiredFieldValidator ID="rfvThreshold" runat="server" ControlToValidate="txtConditionValue"
                    ErrorMessage="Threshold is required." CssClass="text-danger small" Display="Dynamic" />
                <small class="text-muted">e.g. Condition = "Quizzes Completed", Threshold = 5 means awarded after 5 quizzes passed.</small>
            </div>

            <asp:HiddenField ID="hdnId" runat="server" />

            <div class="d-flex gap-3 pt-3 border-top">
                <asp:Button ID="btnSave" runat="server" Text="Save Achievement" CssClass="btn btn-brand px-4 py-2 fw-semibold" OnClick="btnSave_Click" />
                <a class="btn btn-outline-secondary px-4 py-2" href="~/Pages/Admin/Achievements.aspx" runat="server">Cancel</a>
            </div>
        </div>
    </div>
</asp:Content>

