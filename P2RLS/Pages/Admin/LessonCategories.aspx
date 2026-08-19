<%@ Page Title="Lesson Categories" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="LessonCategories.aspx.cs" Inherits="P2RLS.Pages.Admin.LessonCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Top Bar -->
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
            <div>
                <a class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-2 d-inline-flex align-items-center gap-1" href="~/Pages/Admin/Dashboard.aspx" runat="server">
                    <i class="bi bi-arrow-left"></i> Admin Control Center
                </a>
                <h1 class="h3 fw-bold text-dark mb-0">Curriculum Stages / Categories</h1>
            </div>
            <a class="btn btn-brand rounded-pill px-4 py-2 fw-semibold d-inline-flex align-items-center gap-2" href="~/Pages/Admin/LessonCategoryEdit.aspx" runat="server">
                <i class="bi bi-plus-lg"></i> New Category Stage
            </a>
        </div>

        <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="row mb-4">
                <div class="col-md-5">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control rounded-start-pill ps-3" placeholder="Search by name..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-brand rounded-end-pill px-4" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <asp:Literal ID="litEmpty" runat="server" />

            <div class="table-responsive">
                <asp:GridView ID="gvCategories" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false" DataKeyNames="id"
                    AllowSorting="true" OnSorting="gvCategories_Sorting"
                    AllowCustomPaging="true" AllowPaging="true" PageSize="10"
                    OnPageIndexChanging="gvCategories_PageIndexChanging"
                    OnRowCommand="gvCategories_RowCommand">
                    <HeaderStyle CssClass="table-light text-muted small fw-bold" />
                    <Columns>
                        <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" ItemStyle-CssClass="fw-bold text-dark" />
                        <asp:BoundField DataField="level_number" HeaderText="Level" SortExpression="level_number" ItemStyle-CssClass="fw-semibold text-primary" />
                        <asp:BoundField DataField="estimated_time" HeaderText="Estimated Time" NullDisplayText="45m" ItemStyle-CssClass="text-muted" />
                        <asp:BoundField DataField="description" HeaderText="Description" ItemStyle-CssClass="text-muted small" />
                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <a class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1" href='<%# "~/Pages/Admin/LessonCategoryEdit.aspx?id=" + Eval("id") %>' runat="server">Edit</a>
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                    CommandName="DeleteCategory" CommandArgument='<%# Eval("id") %>'
                                    data-confirm="Delete this category? Lessons inside it must be removed first."
                                    data-confirm-title="Delete Category">
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

