<%@ Page Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="FinancialSimulationEdit.aspx.cs" Inherits="P2RLS.Pages.Admin.FinancialSimulationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-800 mx-auto">
        <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><asp:Literal ID="litHeading" runat="server" Text="New Simulation" /></h1>
                    <p class="text-muted small mb-0">Create branching interactive scenarios for student practice.</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="~/Pages/Admin/FinancialSimulations.aspx" runat="server">
                    &larr; Back to Simulations
                </a>
            </div>

            <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-4" DisplayMode="BulletList" />

            <div class="mb-3">
                <label for="<%= txtTitle.ClientID %>" class="form-label fw-bold small text-dark">Scenario Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="150" placeholder="e.g. Emergency Fund or High-Interest Debt?" />
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                    ErrorMessage="Title is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label for="<%= txtDescription.ClientID %>" class="form-label fw-bold small text-dark">Scenario Story & Dilemma</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" 
                    placeholder="Describe the context, the amount of money involved, and what dilemma the learner faces." />
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                    ErrorMessage="Description is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-4">
                <label for="<%= txtLevelNumber.ClientID %>" class="form-label fw-bold small text-dark">Curriculum Level (1 to 6)</label>
                <asp:TextBox ID="txtLevelNumber" runat="server" CssClass="form-control" TextMode="Number" style="max-width: 160px;" placeholder="1" />
                <asp:RequiredFieldValidator ID="rfvLevel" runat="server" ControlToValidate="txtLevelNumber"
                    ErrorMessage="Level number is required." CssClass="text-danger small" Display="Dynamic" />
                <asp:RangeValidator ID="rvLevel" runat="server" ControlToValidate="txtLevelNumber"
                    MinimumValue="1" MaximumValue="6" Type="Integer"
                    ErrorMessage="Level must be between 1 and 6." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="pt-3 border-top mb-3">
                <h2 class="h5 fw-bold text-dark mb-1">Decision Choices & Consequences</h2>
                <p class="text-muted small">Provide 3 distinct choices with realistic financial analysis and outcomes.</p>
            </div>

            <div class="mb-3 p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                <label class="form-label fw-bold text-dark small mb-2"><i class="bi bi-1-circle text-primary me-1"></i> Choice 1</label>
                <asp:TextBox ID="txtChoice1" runat="server" CssClass="form-control mb-2" placeholder="Action choice 1" />
                <asp:TextBox ID="txtOutcome1" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Outcome and lesson learned from choice 1" />
                <asp:RequiredFieldValidator ID="rfvC1" runat="server" ControlToValidate="txtChoice1" ErrorMessage="Choice 1 text is required." CssClass="text-danger small" Display="Dynamic" />
                <asp:RequiredFieldValidator ID="rfvO1" runat="server" ControlToValidate="txtOutcome1" ErrorMessage="Choice 1 outcome is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-3 p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                <label class="form-label fw-bold text-dark small mb-2"><i class="bi bi-2-circle text-primary me-1"></i> Choice 2</label>
                <asp:TextBox ID="txtChoice2" runat="server" CssClass="form-control mb-2" placeholder="Action choice 2" />
                <asp:TextBox ID="txtOutcome2" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Outcome and lesson learned from choice 2" />
                <asp:RequiredFieldValidator ID="rfvC2" runat="server" ControlToValidate="txtChoice2" ErrorMessage="Choice 2 text is required." CssClass="text-danger small" Display="Dynamic" />
                <asp:RequiredFieldValidator ID="rfvO2" runat="server" ControlToValidate="txtOutcome2" ErrorMessage="Choice 2 outcome is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-4 p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                <label class="form-label fw-bold text-dark small mb-2"><i class="bi bi-3-circle text-primary me-1"></i> Choice 3</label>
                <asp:TextBox ID="txtChoice3" runat="server" CssClass="form-control mb-2" placeholder="Action choice 3" />
                <asp:TextBox ID="txtOutcome3" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Outcome and lesson learned from choice 3" />
                <asp:RequiredFieldValidator ID="rfvC3" runat="server" ControlToValidate="txtChoice3" ErrorMessage="Choice 3 text is required." CssClass="text-danger small" Display="Dynamic" />
                <asp:RequiredFieldValidator ID="rfvO3" runat="server" ControlToValidate="txtOutcome3" ErrorMessage="Choice 3 outcome is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <asp:HiddenField ID="hdnId" runat="server" />

            <div class="d-flex gap-3 pt-3 border-top">
                <asp:Button ID="btnSave" runat="server" Text="Save Simulation" CssClass="btn btn-brand px-4 py-2 fw-semibold" OnClick="btnSave_Click" />
                <a class="btn btn-outline-secondary px-4 py-2" href="~/Pages/Admin/FinancialSimulations.aspx" runat="server">Cancel</a>
            </div>
        </div>
    </div>
</asp:Content>

