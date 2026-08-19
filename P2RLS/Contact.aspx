<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="P2RLS.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 max-w-700 mx-auto">
        <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius: 24px; background: #FFFFFF;">
            <span class="badge badge-brand text-uppercase px-3 py-1 mb-2 rounded-pill fw-bold" style="font-size: 0.72rem; width: fit-content;">
                SUPPORT & INQUIRIES
            </span>
            <h1 class="h2 fw-bold text-dark mb-3">Get in Touch</h1>
            <p class="text-secondary mb-4">Have questions about our financial curriculum, simulations, or need support? Reach out anytime.</p>
            
            <div class="d-flex flex-column gap-3">
                <div class="d-flex align-items-center gap-3 p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                    <div class="icon-box" style="width: 42px; height: 42px; background: #F5F3FF; color: #7C3AED; border-radius: 12px; display: inline-flex; align-items: center; justify-content: center;">
                        <i class="bi bi-envelope-fill"></i>
                    </div>
                    <div>
                        <div class="small text-muted fw-semibold">Email Support</div>
                        <a href="mailto:support@p2rls.com" class="fw-bold text-dark text-decoration-none">support@p2rls.com</a>
                    </div>
                </div>

                <div class="d-flex align-items-center gap-3 p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                    <div class="icon-box" style="width: 42px; height: 42px; background: #F0FDF4; color: #16A34A; border-radius: 12px; display: inline-flex; align-items: center; justify-content: center;">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <div>
                        <div class="small text-muted fw-semibold">Platform Status</div>
                        <span class="fw-bold text-success">All Simulation Engines Operational</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
