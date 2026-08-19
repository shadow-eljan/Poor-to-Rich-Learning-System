<%@ Page Title="Learning Path" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="P2RLS.Pages.User.Lessons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Header -->
        <div class="mb-4">
            <h1 class="h2 fw-bold text-dark mb-1">Learning Path</h1>
            <p class="text-muted" style="max-width: 750px;">
                Master the foundations of personal finance through our structured curriculum. Every completed module brings you closer to Financial Freedom.
            </p>
        </div>

        <asp:Literal ID="litLockedMsg" runat="server" />

        <!-- 6 Stage Learning Cards Grid (3 Columns) -->
        <div class="row g-4">
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 border-0 shadow-sm overflow-hidden d-flex flex-column" style="border-radius: 20px; background: #FFFFFF;">
                            <!-- Top Thumbnail / Banner with Level Pill Overlay -->
                            <div class="position-relative" style="height: 165px; overflow: hidden; background: #F1F5F9;">
                                <%# GetCategoryBannerHtml(Eval("image_url"), Eval("level_number")) %>
                                <span class="badge bg-white bg-opacity-95 text-dark fw-extrabold px-3 py-1 rounded-pill shadow-sm" 
                                      style="position: absolute; top: 12px; left: 12px; font-size: 0.75rem; letter-spacing: 0.5px; border: 1px solid rgba(0,0,0,0.06);">
                                    LVL <%#: Eval("level_number") %>
                                </span>
                            </div>

                            <!-- Card Body -->
                            <div class="p-4 d-flex flex-column flex-grow-1">
                                <h2 class="h5 fw-bold text-dark mb-2"><%#: Eval("name") %></h2>
                                <p class="text-muted small mb-4 flex-grow-1" style="min-height: 40px; line-height: 1.5;">
                                    <%#: Eval("description") %>
                                </p>

                                <!-- Progress Bar & Count -->
                                <div class="mb-3">
                                    <%# (int)Eval("is_completed") == 1
                                        ? string.Format(@"
                                            <div class='d-flex justify-content-between align-items-center small mb-1 fw-bold'>
                                                <span class='text-success'>100% Complete</span>
                                                <span class='text-muted'>{0} / {0} Lessons</span>
                                            </div>
                                            <div class='progress' style='height: 6px; background:#E2E8F0; border-radius:999px;'>
                                                <div class='progress-bar bg-success' style='width: 100%; border-radius:999px;'></div>
                                            </div>", Eval("TotalLessons"))
                                        : (int)Eval("is_unlocked") == 1
                                            ? string.Format(@"
                                                <div class='d-flex justify-content-between align-items-center small mb-1 fw-bold'>
                                                    <span class='text-primary'>{0}% Complete</span>
                                                    <span class='text-muted'>{1} / {2} Lessons</span>
                                                </div>
                                                <div class='progress' style='height: 6px; background:#E2E8F0; border-radius:999px;'>
                                                    <div class='progress-bar bg-primary' style='width: {0}%; border-radius:999px;'></div>
                                                </div>", ComputePercent(Eval("TotalLessons"), Eval("CompletedLessons")), Eval("CompletedLessons"), Eval("TotalLessons"))
                                            : string.Format(@"
                                                <div class='d-flex justify-content-between align-items-center small mb-1 fw-semibold'>
                                                    <span class='text-muted'>Locked</span>
                                                    <span class='text-muted'>0 / {0} Lessons</span>
                                                </div>
                                                <div class='progress' style='height: 6px; background:#E2E8F0; border-radius:999px;'>
                                                    <div class='progress-bar bg-secondary bg-opacity-25' style='width: 0%; border-radius:999px;'></div>
                                                </div>", Eval("TotalLessons")) %>
                                </div>

                                <!-- Card Footer: Time Estimate + Action Button -->
                                <div class="d-flex justify-content-between align-items-center pt-3 border-top mt-auto">
                                    <div class="d-flex align-items-center gap-1 text-muted small fw-semibold">
                                        <i class="bi bi-clock"></i>
                                        <%#: Eval("estimated_time") != DBNull.Value && !string.IsNullOrEmpty(Eval("estimated_time").ToString()) ? Eval("estimated_time") : "45m" %>
                                    </div>

                                    <div>
                                        <%# (int)Eval("is_completed") == 1
                                            ? "<a class='btn btn-sm btn-outline-success rounded-3 px-3 fw-bold' href='" + ResolveUrl("~/Pages/User/LessonList.aspx?categoryId=" + Eval("id")) + "'>Review <i class='bi bi-arrow-counterclockwise ms-1'></i></a>"
                                            : (int)Eval("is_unlocked") == 1
                                                ? "<a class='btn btn-sm btn-brand rounded-3 px-3 fw-bold' href='" + ResolveUrl("~/Pages/User/LessonList.aspx?categoryId=" + Eval("id")) + "'>Continue <i class='bi bi-arrow-right ms-1'></i></a>"
                                                : "<button class='btn btn-sm btn-secondary bg-opacity-25 border-0 text-muted rounded-3 px-3 fw-bold' disabled>Locked &#128274;</button>" %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

