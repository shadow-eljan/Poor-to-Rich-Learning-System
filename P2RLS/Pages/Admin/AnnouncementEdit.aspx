<%@ Page Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="AnnouncementEdit.aspx.cs" Inherits="P2RLS.Pages.Admin.AnnouncementEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-700 mx-auto">
        <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><asp:Literal ID="litHeading" runat="server" Text="New Announcement" /></h1>
                    <p class="text-muted small mb-0">Broadcast platform updates and curriculum news to all learners.</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="~/Pages/Admin/Announcements.aspx" runat="server">
                    &larr; Back to Announcements
                </a>
            </div>

            <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-4" DisplayMode="BulletList" />

            <div class="mb-3">
                <label for="<%= txtTitle.ClientID %>" class="form-label fw-bold small text-dark">Announcement Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="150" placeholder="e.g. New Simulation Mode Released!" />
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                    ErrorMessage="Title is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-4">
                <label for="<%= txtContent.ClientID %>" class="form-label fw-bold small text-dark">Announcement Body / Content</label>
                <asp:TextBox ID="txtContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="6" 
                    placeholder="Write the full announcement text here..." />
                <asp:RequiredFieldValidator ID="rfvContent" runat="server" ControlToValidate="txtContent"
                    ErrorMessage="Content is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <asp:HiddenField ID="hdnId" runat="server" />

            <div class="d-flex gap-3 pt-3 border-top">
                <asp:Button ID="btnSave" runat="server" Text="Publish Announcement" CssClass="btn btn-brand px-4 py-2 fw-semibold" OnClick="btnSave_Click" />
                <a class="btn btn-outline-secondary px-4 py-2" href="~/Pages/Admin/Announcements.aspx" runat="server">Cancel</a>
            </div>
        </div>
    </div>
</asp:Content>

