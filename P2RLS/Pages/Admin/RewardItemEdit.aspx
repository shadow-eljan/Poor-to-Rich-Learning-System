<%@ Page Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true"
    CodeBehind="RewardItemEdit.aspx.cs" Inherits="P2RLS.Pages.Admin.RewardItemEdit" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container py-4 max-w-700 mx-auto">
            <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
                <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                    <div>
                        <h1 class="h3 fw-bold text-dark mb-1">
                            <asp:Literal ID="litHeading" runat="server" Text="New Reward Item" />
                        </h1>
                        <p class="text-muted small mb-0">Upload shop assets: avatars, banners, avatar frames, or titles.
                        </p>
                    </div>
                    <a class="btn btn-outline-secondary btn-sm" href="~/Pages/Admin/RewardItems.aspx" runat="server">
                        &larr; Back to Shop Items
                    </a>
                </div>

                <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-4"
                    DisplayMode="BulletList" />
                <asp:Literal ID="litAlert" runat="server" />

                <div class="mb-3">
                    <label for="<%= txtName.ClientID %>" class="form-label fw-bold small text-dark">Item Title</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="100"
                        placeholder="e.g. Neon Cyber Avatar / Golden Wings Banner / Diamond Frame" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                        ErrorMessage="Name is required." CssClass="text-danger small" Display="Dynamic" />
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label for="<%= ddlCategory.ClientID %>" class="form-label fw-bold small text-dark">Asset
                            Category</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Avatar (Profile Pic)" Value="Avatar" />
                            <asp:ListItem Text="Banner (Profile Background)" Value="Banner" />
                            <asp:ListItem Text="Border (Avatar Frame)" Value="Border" />
                            <asp:ListItem Text="Title (Badge / Tag)" Value="Title" />
                            <asp:ListItem Text="Cosmetic Other" Value="Cosmetic" />
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label for="<%= txtCost.ClientID %>" class="form-label fw-bold small text-dark">Price (Virtual
                            Coins)</label>
                        <asp:TextBox ID="txtCost" runat="server" CssClass="form-control" TextMode="Number"
                            placeholder="150" />
                        <asp:RequiredFieldValidator ID="rfvCost" runat="server" ControlToValidate="txtCost"
                            ErrorMessage="Cost is required." CssClass="text-danger small" Display="Dynamic" />
                        <asp:RangeValidator ID="rvCost" runat="server" ControlToValidate="txtCost" MinimumValue="0"
                            MaximumValue="1000000" Type="Integer" ErrorMessage="Cost must be 0 or higher."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>
                </div>

                <div class="mb-3">
                    <label for="<%= txtType.ClientID %>" class="form-label fw-bold small text-dark">Item Description /
                        Perk</label>
                    <asp:TextBox ID="txtType" runat="server" CssClass="form-control" MaxLength="100"
                        placeholder="e.g. Legendary animated border frame for your profile" />
                </div>

                <!-- Asset Image / Frame Upload -->
                <div class="mb-4 p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                    <label class="form-label fw-bold small text-dark mb-1">
                        <i class="bi bi-image text-primary me-1"></i> Asset Image / Frame Upload (PNG, JPG, SVG, WebP)
                    </label>
                    <p class="text-muted small mb-2">Upload the avatar image, background banner graphic, or frame
                        overlay.</p>
                    <asp:FileUpload ID="fuAssetImage" runat="server" CssClass="form-control mb-2"
                        accept=".png,.jpg,.jpeg,.webp,.gif,.svg" />

                    <asp:PlaceHolder ID="phPreview" runat="server" Visible="false">
                        <div class="mt-2 d-flex align-items-center gap-3">
                            <span class="small text-muted fw-semibold">Current Preview:</span>
                            <asp:Image ID="imgPreview" runat="server" CssClass="rounded shadow-sm"
                                style="max-height: 80px; max-width: 120px; object-fit: cover;" />
                        </div>
                    </asp:PlaceHolder>
                </div>

                <asp:HiddenField ID="hdnId" runat="server" />
                <asp:HiddenField ID="hdnExistingImageUrl" runat="server" />

                <div class="d-flex gap-3 pt-3 border-top">
                    <asp:Button ID="btnSave" runat="server" Text="Save Item"
                        CssClass="btn btn-brand px-4 py-2 fw-semibold" OnClick="btnSave_Click" />
                    <a class="btn btn-outline-secondary px-4 py-2" href="~/Pages/Admin/RewardItems.aspx"
                        runat="server">Cancel</a>
                </div>
            </div>
        </div>
    </asp:Content>