<%@ Page Title="Error" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="P2RLS.Pages.Shared.ErrorPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 text-center max-w-700 mx-auto">
        <div class="card p-5 border-0 shadow-sm" style="border-radius: 24px; background: #FFFFFF;">
            <div class="fs-1 mb-3">⚠️</div>
            <h1 class="h3 fw-bold text-dark mb-2">Something went wrong</h1>
            <p class="text-muted mb-4">An unexpected error occurred. Please try again or return to safety.</p>
            <div>
                <a class="btn btn-brand rounded-pill px-4 py-2 fw-bold" href="~/Default.aspx" runat="server">Back to Home</a>
            </div>
        </div>
    </div>
</asp:Content>

