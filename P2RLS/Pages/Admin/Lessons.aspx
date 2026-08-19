<%@ Page Title="Lessons" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="P2RLS.Pages.Admin.Lessons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Top Bar -->
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
            <div>
                <a class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-2" href="~/Pages/Admin/Dashboard.aspx" runat="server">
                    &larr; Admin Control Center
                </a>
                <h1 class="h3 fw-bold text-dark mb-0">Curriculum Chapters / Lessons</h1>
            </div>
            <a class="btn btn-brand rounded-pill px-4 py-2 fw-semibold" href="~/Pages/Admin/LessonEdit.aspx" runat="server">
                + New Chapter Lesson
            </a>
        </div>

        <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="row mb-4 g-2">
                <div class="col-md-5">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control rounded-pill ps-3" placeholder="Search by title..." />
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlCategoryFilter" runat="server" CssClass="form-select rounded-pill" />
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnSearch" runat="server" Text="Apply Filter" CssClass="btn btn-brand rounded-pill w-100 fw-semibold" OnClick="btnSearch_Click" />
                </div>
            </div>

            <asp:Literal ID="litEmpty" runat="server" />

            <div class="table-responsive">
                <asp:GridView ID="gvLessons" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false" DataKeyNames="id"
                    AllowSorting="true" OnSorting="gvLessons_Sorting"
                    AllowCustomPaging="true" AllowPaging="true" PageSize="10"
                    OnPageIndexChanging="gvLessons_PageIndexChanging"
                    OnRowCommand="gvLessons_RowCommand">
                    <HeaderStyle CssClass="table-light text-muted small fw-bold" />
                    <Columns>
                        <asp:BoundField DataField="title" HeaderText="Chapter Title" SortExpression="title" ItemStyle-CssClass="fw-bold text-dark" />
                        <asp:BoundField DataField="category_name" HeaderText="Curriculum Stage" ItemStyle-CssClass="text-primary fw-semibold" />
                        <asp:BoundField DataField="order_index" HeaderText="Sequence Order" SortExpression="order_index" ItemStyle-CssClass="text-center" />
                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <a class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1" href='<%# "~/Pages/Admin/LessonEdit.aspx?id=" + Eval("id") %>' runat="server">Edit</a>
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                    CommandName="DeleteLesson" CommandArgument='<%# Eval("id") %>'
                                    data-confirm="Delete this lesson? Its quiz data must be removed first."
                                    data-confirm-title="Delete Lesson">
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

