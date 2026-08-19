<%@ Page Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="LessonEdit.aspx.cs" Inherits="P2RLS.Pages.Admin.LessonEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-900 mx-auto">
        <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 20px;">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><asp:Literal ID="litHeading" runat="server" Text="New Lesson" /></h1>
                    <p class="text-muted small mb-0">Create or edit a curriculum chapter with rich takeaways and quote templates.</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="~/Pages/Admin/Lessons.aspx" runat="server">
                    &larr; Back to Lessons
                </a>
            </div>

            <asp:ValidationSummary ID="valSummary" runat="server" CssClass="alert alert-danger mb-4" DisplayMode="BulletList" />

            <!-- 1. Category -->
            <div class="mb-3">
                <label for="<%= ddlCategory.ClientID %>" class="form-label fw-bold small text-dark">Curriculum Category / Level</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select form-select-lg" />
            </div>

            <!-- 2. Lesson Title -->
            <div class="mb-3">
                <label for="<%= txtTitle.ClientID %>" class="form-label fw-bold small text-dark">Lesson Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="150" placeholder="e.g. Compound Interest Mastery" />
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                    ErrorMessage="Title is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <!-- 3. Lesson Content -->
            <div class="mb-4">
                <label for="<%= txtContent.ClientID %>" class="form-label fw-bold small text-dark">Lesson Main Content (Supports HTML / Text)</label>
                <asp:TextBox ID="txtContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10" 
                    placeholder="Enter the core educational content. You can write paragraphs, sub-headings (e.g. &lt;h3&gt;), and key explanations." />
                <asp:RequiredFieldValidator ID="rfvContent" runat="server" ControlToValidate="txtContent"
                    ErrorMessage="Content is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <!-- 4. Key Takeaways -->
            <div class="mb-4 p-3 rounded-4" style="background:#F8FAFC; border:1px solid #E2E8F0;">
                <label for="<%= txtKeyTakeaways.ClientID %>" class="form-label fw-bold small text-dark d-flex align-items-center gap-2">
                    <i class="bi bi-lightbulb-fill text-warning"></i> Key Takeaways (One per line or formatted)
                </label>
                <p class="text-muted small mb-2">
                    Format each takeaway on a new line. You can format as <code>Title: Description</code>, e.g.<br />
                    <code>Principal + Interest: Interest is earned on previous interest, not just base.</code><br />
                    <code>Time is your Ally: The longer the period, the more dramatic the results.</code>
                </p>
                <asp:TextBox ID="txtKeyTakeaways" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" 
                    placeholder="Principal + Interest: Interest is earned on your previous interest, not just the base.&#10;Time is your Ally: The longer the period, the more dramatic the results.&#10;Frequency Matters: More frequent compounding yields higher returns." />
            </div>

            <!-- 5. Quote Section -->
            <div class="mb-4 p-3 rounded-4" style="background:#F5F3FF; border:1px solid #DDD6FE;">
                <label class="form-label fw-bold small text-dark d-flex align-items-center gap-2 mb-2">
                    <i class="bi bi-chat-square-quote-fill text-primary"></i> Motivational / Educational Quote
                </label>
                <div class="row g-3">
                    <div class="col-md-8">
                        <label for="<%= txtQuote.ClientID %>" class="form-label small text-muted">Quote Text</label>
                        <asp:TextBox ID="txtQuote" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" 
                            placeholder="e.g. The most powerful force in the universe is compound interest." />
                    </div>
                    <div class="col-md-4">
                        <label for="<%= txtQuoteAuthor.ClientID %>" class="form-label small text-muted">Author / Attribution</label>
                        <asp:TextBox ID="txtQuoteAuthor" runat="server" CssClass="form-control" MaxLength="150" 
                            placeholder="e.g. Albert Einstein (Attributed)" />
                    </div>
                </div>
            </div>

            <!-- 6. Display Order -->
            <div class="mb-4">
                <label for="<%= txtOrderIndex.ClientID %>" class="form-label fw-bold small text-dark">Display Order Index</label>
                <asp:TextBox ID="txtOrderIndex" runat="server" CssClass="form-control" TextMode="Number" style="max-width: 180px;" placeholder="1" />
                <small class="text-muted">Controls the sequence order sub-lessons appear in (1 = first, 2 = second…).</small>
            </div>

            <asp:HiddenField ID="hdnId" runat="server" />

            <div class="d-flex gap-3 pt-3 border-top">
                <asp:Button ID="btnSave" runat="server" Text="Save Lesson" CssClass="btn btn-brand px-4 py-2 fw-semibold" OnClick="btnSave_Click" />
                <a class="btn btn-outline-secondary px-4 py-2" href="~/Pages/Admin/Lessons.aspx" runat="server">Cancel</a>
            </div>
        </div>
    </div>
</asp:Content>

