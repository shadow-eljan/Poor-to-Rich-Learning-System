<%@ Page Title="Lessons" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="LessonList.aspx.cs" Inherits="P2RLS.Pages.User.LessonList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-900 mx-auto">
        <!-- Header Banner -->
        <div class="card p-4 p-md-5 mb-4 border-0 shadow-sm" style="border-radius: 20px; background: linear-gradient(135deg, #FFFFFF 0%, #F5F3FF 100%);">
            <a class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-3" href="~/Pages/User/Lessons.aspx" runat="server">
                &larr; Back to Learning Path
            </a>
            <span class="badge badge-brand text-uppercase px-3 py-1 mb-2 rounded-pill fw-bold" style="font-size: 0.72rem; width: fit-content;">
                CURRICULUM MODULE
            </span>
            <h1 class="h2 fw-bold text-dark mb-2"><asp:Literal ID="litCategoryName" runat="server" /></h1>
            <p class="text-muted mb-0"><asp:Literal ID="litCategoryDesc" runat="server" /></p>
        </div>

        <!-- Lessons / Chapters List -->
        <div class="card border-0 shadow-sm p-4" style="border-radius: 20px; background: #FFFFFF;">
            <h2 class="h5 fw-bold text-dark mb-3"><i class="bi bi-list-nested text-primary me-2"></i>Chapters in this Stage</h2>

            <div class="list-group list-group-flush">
                <asp:Repeater ID="rptLessons" runat="server">
                    <ItemTemplate>
                        <div class="list-group-item px-0 py-3 d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 border-bottom">
                            <div class="d-flex align-items-center gap-3">
                                <span class="badge bg-light text-primary border px-3 py-2 rounded-pill fw-bold">
                                    Chapter <%#: Eval("order_index") %>
                                </span>
                                <div>
                                    <a href='<%#: ResolveUrl("~/Pages/User/LessonView.aspx?id=" + Eval("id")) %>' class="fw-bold text-dark text-decoration-none fs-6">
                                        <%#: Eval("title") %>
                                    </a>
                                </div>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <%# (int)Eval("is_completed") == 1 
                                    ? "<span class='badge bg-success bg-opacity-10 text-success fw-bold px-3 py-2 rounded-pill'>&#10003; Read</span>" 
                                    : "<span class='badge bg-light text-muted border px-3 py-2 rounded-pill'>Not Read</span>" %>

                                <%# (int)Eval("has_quiz") == 1 
                                    ? ((int)Eval("is_quiz_passed") == 1 
                                        ? "<span class='badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-2 rounded-pill'>&#10003; Quiz Passed</span>" 
                                        : "<span class='badge bg-warning bg-opacity-20 text-dark fw-bold px-3 py-2 rounded-pill'>Quiz Pending</span>")
                                    : "" %>

                                <a class="btn btn-sm btn-brand px-3 py-1 rounded-pill" href='<%#: ResolveUrl("~/Pages/User/LessonView.aspx?id=" + Eval("id")) %>'>
                                    Open &rarr;
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>

