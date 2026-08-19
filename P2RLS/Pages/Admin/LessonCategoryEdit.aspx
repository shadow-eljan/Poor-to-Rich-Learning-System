<%@ Page Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="LessonCategoryEdit.aspx.cs" Inherits="P2RLS.Pages.Admin.LessonCategoryEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-700 mx-auto">
        <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 20px;">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><asp:Literal ID="litHeading" runat="server" Text="New Stage / Category" /></h1>
                    <p class="text-muted small mb-0">Configure curriculum stage info, progression tier, duration, and thumbnail banner.</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="~/Pages/Admin/LessonCategories.aspx" runat="server">
                    &larr; Back to Stages
                </a>
            </div>

            <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-4" DisplayMode="BulletList" />

            <!-- 1. Category Name -->
            <div class="mb-3">
                <label for="<%= txtName.ClientID %>" class="form-label fw-bold small text-dark">Stage / Category Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="100" placeholder="e.g. Survival, Saver, Borrowing & Credit" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <!-- 2. Level Number -->
            <div class="mb-3">
                <label for="<%= txtLevelNumber.ClientID %>" class="form-label fw-bold small text-dark">Progression Level (1 to 6)</label>
                <asp:TextBox ID="txtLevelNumber" runat="server" CssClass="form-control" TextMode="Number" style="max-width: 160px;" placeholder="1" />
                <asp:RequiredFieldValidator ID="rfvLevel" runat="server" ControlToValidate="txtLevelNumber"
                    ErrorMessage="Level number is required." CssClass="text-danger small" Display="Dynamic" />
                <asp:RangeValidator ID="rvLevel" runat="server" ControlToValidate="txtLevelNumber"
                    MinimumValue="1" MaximumValue="6" Type="Integer"
                    ErrorMessage="Level must be between 1 and 6." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <!-- 3. Description -->
            <div class="mb-3">
                <label for="<%= txtDescription.ClientID %>" class="form-label fw-bold small text-dark">Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" MaxLength="500" 
                    placeholder="Briefly describe what financial concepts are mastered in this stage." />
            </div>

            <!-- 4. Estimated Time -->
            <div class="mb-3">
                <label for="<%= txtEstimatedTime.ClientID %>" class="form-label fw-bold small text-dark">Estimated Completion Time</label>
                <asp:TextBox ID="txtEstimatedTime" runat="server" CssClass="form-control" MaxLength="50" placeholder="e.g. 45m, 1h 20m, 2h 10m" />
                <small class="text-muted">Displayed on the Learning Path card to guide students.</small>
            </div>

            <!-- 5. Image Upload & Preview -->
            <div class="mb-4 p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                <label class="form-label fw-bold small text-dark d-flex align-items-center gap-2 mb-2">
                    <i class="bi bi-image text-primary"></i> Category Thumbnail / Card Banner
                </label>

                <!-- Existing Image Preview -->
                <asp:PlaceHolder ID="phExistingImage" runat="server" Visible="false">
                    <div class="mb-3 d-flex align-items-center gap-3">
                        <asp:Image ID="imgPreview" runat="server" CssClass="rounded-3 shadow-sm border" style="width: 140px; height: 80px; object-fit: cover;" />
                        <div class="small text-muted">Current image</div>
                    </div>
                </asp:PlaceHolder>

                <div class="mb-2">
                    <label for="<%= fuImage.ClientID %>" class="form-label small text-muted">Upload Image File (JPG, PNG, WebP)</label>
                    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                </div>

                <div>
                    <label for="<%= txtImageUrl.ClientID %>" class="form-label small text-muted">Or Image URL / Path</label>
                    <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" MaxLength="500" placeholder="~/Uploads/Categories/banner.jpg or /Images/sample.png" />
                </div>
            </div>

            <asp:HiddenField ID="hdnId" runat="server" />

            <div class="d-flex gap-3 pt-3 border-top">
                <asp:Button ID="btnSave" runat="server" Text="Save Category" CssClass="btn btn-brand px-4 py-2 fw-semibold" OnClick="btnSave_Click" />
                <a class="btn btn-outline-secondary px-4 py-2" href="~/Pages/Admin/LessonCategories.aspx" runat="server">Cancel</a>
            </div>
        </div>
    </div>
</asp:Content>

