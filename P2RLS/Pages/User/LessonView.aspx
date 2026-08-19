<%@ Page Title="Lesson View" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="LessonView.aspx.cs" Inherits="P2RLS.Pages.User.LessonView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-1100 mx-auto">
        <!-- TOP HEADER: Category Pill Badge + Title + Progress Bar -->
        <div class="mb-4">
            <span class="badge badge-brand text-uppercase px-3 py-2 mb-2 rounded-pill fw-bold" style="font-size: 0.75rem; letter-spacing: 0.5px;">
                <asp:Literal ID="litCategoryBadge" runat="server" />
            </span>
            <h1 class="h2 fw-bold text-dark mb-3"><asp:Literal ID="litTitle" runat="server" /></h1>

            <!-- Lesson Progress Indicator -->
            <div class="d-flex justify-content-between align-items-center small fw-bold mb-1">
                <span class="text-muted">Lesson Progress</span>
                <span class="text-success fw-bold"><asp:Literal ID="litProgressPercent" runat="server" /></span>
            </div>
            <div class="progress" style="height: 8px; border-radius: 999px; background: #E2E8F0;">
                <div id="progressBar" runat="server" class="progress-bar bg-success" style="border-radius: 999px;"></div>
            </div>
        </div>

        <!-- MAIN LAYOUT: Left (Content) | Right (Key Takeaways + Quote) -->
        <div class="row g-4">
            <!-- Left Main Content Column (8 cols) -->
            <div class="col-lg-8">
                <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
                    <article class="lesson-article-body" style="font-size: 1.05rem; line-height: 1.8; color: #334155;">
                        <asp:Literal ID="litContent" runat="server" />
                    </article>
                </div>
            </div>

            <!-- Right Sidebar Column (4 cols) -->
            <div class="col-lg-4">
                <!-- 1. Key Takeaways Card (Dark Slate) -->
                <div class="card p-4 border-0 shadow-sm text-white mb-4" 
                     style="background: #1E293B; border-radius: 20px;">
                    <h2 class="h6 fw-bold text-white mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-lightbulb-fill text-warning fs-5"></i> Key Takeaways
                    </h2>

                    <!-- Takeaways List -->
                    <div class="mb-3">
                        <asp:Literal ID="litTakeaways" runat="server" />
                    </div>

                    <!-- Next Lesson Teaser (Time removed as requested) -->
                    <asp:PlaceHolder ID="phNextLesson" runat="server">
                        <div class="p-3 rounded-3 mt-3" style="background: rgba(255, 255, 255, 0.07); border: 1px solid rgba(255, 255, 255, 0.12);">
                            <div class="text-white opacity-75 small fw-bold mb-1" style="font-size: 0.72rem; letter-spacing: 0.5px;">NEXT LESSON</div>
                            <div class="fw-bold text-white small"><asp:Literal ID="litNextLessonTitle" runat="server" /></div>
                        </div>
                    </asp:PlaceHolder>
                </div>

                <!-- 2. Motivational Quote Card -->
                <asp:PlaceHolder ID="phQuote" runat="server">
                    <div class="card p-4 border-0 shadow-sm" 
                         style="background: #F5F3FF; border-left: 5px solid #7C3AED !important; border-radius: 16px;">
                        <div class="fst-italic fw-bold text-primary mb-2" style="font-size: 1.15rem; line-height: 1.5;">
                            "<asp:Literal ID="litQuoteText" runat="server" />"
                        </div>
                        <div class="text-muted small fw-semibold">
                            <asp:Literal ID="litQuoteAuthor" runat="server" />
                        </div>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>

        <!-- BOTTOM ACTION BAR: Previous, Back to Chapters, Take Quiz -->
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mt-4 pt-4 border-top">
            <div>
                <a id="lnkPrev" runat="server" class="btn btn-outline-secondary px-4 py-2 rounded-pill fw-semibold">
                    &larr; Previous
                </a>
            </div>
            <div class="d-flex align-items-center gap-2">
                <a id="lnkBackToList" runat="server" class="btn btn-outline-brand px-4 py-2 rounded-pill fw-semibold">
                    All Chapters
                </a>
                <a id="lnkTakeQuiz" runat="server" class="btn btn-brand px-4 py-2 rounded-pill fw-semibold d-inline-flex align-items-center gap-2">
                    Take Quiz <i class="bi bi-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>
</asp:Content>

