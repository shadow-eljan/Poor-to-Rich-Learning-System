<%@ Page Title="Reward Shop" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="RewardShop.aspx.cs" Inherits="P2RLS.Pages.User.RewardShop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Header -->
        <div class="mb-4">
            <h1 class="h2 fw-bold text-dark mb-1">Reward & Cosmetic Shop</h1>
            <p class="text-muted" style="max-width: 700px;">
                Redeem your hard-earned virtual coins for exclusive profile titles, badges, and interface themes.
            </p>
        </div>

        <asp:Literal ID="litMessage" runat="server" />

        <div class="row g-4">
            <asp:Repeater ID="rptItems" runat="server" OnItemCommand="rptItems_ItemCommand">
                <ItemTemplate>
                    <div class="col-sm-6 col-md-4 col-lg-3">
                        <div class="card h-100 border-0 shadow-sm p-4 text-center d-flex flex-column" style="border-radius: 20px; background: #FFFFFF;">
                            <div class="mb-2">
                                <%# RenderCategoryBadge(Eval("category")) %>
                            </div>
                            
                            <%# RenderShopItemIcon(Eval("category"), Eval("image_url")) %>

                            <h2 class="h6 fw-bold text-dark mb-1"><%#: Eval("name") %></h2>
                            <p class="text-muted small mb-3 flex-grow-1"><%#: Eval("type") %></p>
                            
                            <div class="mb-3">
                                <span class="badge bg-warning bg-opacity-20 text-dark fw-bold px-3 py-2 rounded-pill fs-6">
                                    🪙 <%#: Eval("cost") %> coins
                                </span>
                            </div>

                            <div class="mt-auto">
                                <%# (int)Eval("is_owned") == 1 
                                    ? "<span class='badge bg-success bg-opacity-10 text-success fw-bold px-4 py-2 rounded-pill w-100'>&#10003; Owned</span>" 
                                    : "" %>
                                <asp:LinkButton ID="lnkBuy" runat="server" CssClass="btn btn-brand btn-sm rounded-pill w-100 fw-bold py-2"
                                    CommandName="Buy" CommandArgument='<%# Eval("id") %>'
                                    Visible='<%# (int)Eval("is_owned") == 0 %>'>
                                    Unlock Item
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

