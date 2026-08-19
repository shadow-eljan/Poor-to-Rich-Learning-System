<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="P2RLS.Pages.User.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <asp:Literal ID="litAlert" runat="server" />

        <!-- TOP SECTION: Welcome Banner + 4 Stats Cards -->
        <div class="row g-4 mb-4 align-items-start">
            <!-- Welcome Hero Profile Card (Left) -->
            <div class="col-lg-7">
                <div class="card card-no-hover p-0 border-0 shadow-sm overflow-hidden" style="border-radius: 24px; background: #FFFFFF;">
                    <!-- Custom Background Banner (no button here anymore) -->
                    <div id="divUserBanner" runat="server" style="height: 180px; background: linear-gradient(135deg, #7C3AED 0%, #C026D3 100%); background-size: cover; background-position: center; position: relative;">
                    </div>

                    <div class="px-4 pb-4" style="position: relative;">
                        <!-- Avatar straddling the banner bottom -->
                        <div style="margin-top: -50px; margin-bottom: 10px;">
                            <div class="position-relative d-inline-block" style="width: 100px; height: 100px;">
                                <asp:Image ID="imgUserAvatar" runat="server" CssClass="rounded-circle shadow w-100 h-100"
                                    style="object-fit: cover; border: 4px solid #FFFFFF; background: #EDE9FE;" Visible="false" />
                                <div id="divUserAvatarFallback" runat="server" class="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold shadow w-100 h-100"
                                     style="font-size: 2.2rem; background: linear-gradient(135deg, #7C3AED, #C026D3); border: 4px solid #FFFFFF;">
                                    <asp:Literal ID="litAvatarInitial" runat="server" />
                                </div>
                                <!-- Border Frame Overlay (if equipped) -->
                                <asp:Image ID="imgUserAvatarBorder" runat="server" Visible="false"
                                    style="position: absolute; top: -7px; left: -7px; width: 114px; height: 114px; pointer-events: none; object-fit: contain;" />
                            </div>
                        </div>

                        <!-- Name row with Customize button inline -->
                        <div class="d-flex align-items-center justify-content-between gap-2 mb-1 flex-wrap">
                            <div>
                                <span class="badge badge-brand mb-1">WELCOME BACK</span>
                                <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                                    <h1 class="h3 fw-bold text-dark mb-0"><asp:Literal ID="litUsername" runat="server" /></h1>
                                    <span class="badge bg-primary rounded-pill px-3 py-1 fw-bold" style="font-size: 0.72rem;">
                                        <asp:Literal ID="litRankTag" runat="server" Text="NOVICE" />
                                    </span>
                                </div>
                                <div class="text-muted small">
                                    <span class="badge bg-primary bg-opacity-10 text-primary fw-semibold me-2">Level <asp:Literal ID="litLevel" runat="server" /></span>
                                    <strong>Stage:</strong> <asp:Literal ID="litCurrentLevelName" runat="server" />
                                </div>
                            </div>
                            <!-- Customize button sits beside the name -->
                            <button type="button"
                                class="btn btn-outline-secondary btn-sm rounded-pill px-3 fw-semibold"
                                data-bs-toggle="collapse" data-bs-target="#userProfileCollapse">
                                <i class="bi bi-palette-fill me-1 text-primary"></i> Customize Profile
                            </button>
                        </div>

                        <!-- COLLAPSED PROFILE SETTINGS & DISCORD-LIKE COSMETICS INVENTORY -->
                        <div class="collapse mt-3 pt-3 border-top" id="userProfileCollapse">


                            <div class="p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                                <ul class="nav nav-pills mb-3" id="profileTab" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active btn-sm rounded-pill px-3 fw-bold" id="identity-tab" data-bs-toggle="tab" data-bs-target="#identity-pane" type="button" role="tab">
                                            Identity &amp; Uploads
                                        </button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link btn-sm rounded-pill px-3 fw-bold" id="inventory-tab" data-bs-toggle="tab" data-bs-target="#inventory-pane" type="button" role="tab">
                                            Owned Cosmetics &amp; Frames
                                        </button>
                                    </li>
                                </ul>

                                <div class="tab-content" id="profileTabContent">
                                    <!-- Tab 1: Custom Uploads -->
                                    <div class="tab-pane fade show active" id="identity-pane" role="tabpanel">
                                        <div class="row g-3">
                                            <div class="col-md-4">
                                                <label class="form-label small fw-bold text-dark">Display Name</label>
                                                <asp:TextBox ID="txtNewUsername" runat="server" CssClass="form-control form-control-sm" MaxLength="50" />
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label small fw-bold text-dark">Upload Avatar</label>
                                                <asp:FileUpload ID="fuAvatar" runat="server" CssClass="form-control form-control-sm" accept=".png,.jpg,.jpeg,.webp,.gif" />
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label small fw-bold text-dark">Upload Banner</label>
                                                <asp:FileUpload ID="fuBanner" runat="server" CssClass="form-control form-control-sm" accept=".png,.jpg,.jpeg,.webp,.gif" />
                                            </div>
                                        </div>
                                        <div class="mt-3 text-end">
                                            <asp:Button ID="btnSaveProfile" runat="server" Text="Save Identity" CssClass="btn btn-brand btn-sm rounded-pill px-4 fw-bold" OnClick="btnSaveProfile_Click" />
                                        </div>
                                    </div>

                                    <!-- Tab 2: Inventory Equip (Discord style) -->
                                    <div class="tab-pane fade" id="inventory-pane" role="tabpanel">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span class="small text-muted fw-semibold">Your cosmetics, frames, and earned rank titles — click to equip:</span>
                                            <a href="~/Pages/User/RewardShop.aspx" class="small fw-bold text-primary" runat="server">Open Shop &rarr;</a>
                                        </div>

                                        <asp:Literal ID="litNoInventory" runat="server" />

                                        <div class="row g-2">
                                            <asp:Repeater ID="rptInventory" runat="server" OnItemCommand="rptInventory_ItemCommand">
                                                <ItemTemplate>
                                                    <div class="col-sm-6 col-md-4">
                                                        <div class="p-2 rounded-3 bg-white border d-flex align-items-center justify-content-between gap-2 shadow-xs">
                                                            <div class="d-flex align-items-center gap-2 overflow-hidden">
                                                                <%# RenderCosmeticIcon(Eval("category"), Eval("image_url"), Eval("name")) %>
                                                                <div class="overflow-hidden">
                                                                    <div class="small fw-bold text-truncate text-dark"><%# Eval("name") %></div>
                                                                    <%# RenderCategoryBadge(Eval("category")) %>
                                                                </div>
                                                            </div>
                                                            <asp:Button ID="btnEquip" runat="server" Text="Equip" CssClass="btn btn-outline-primary btn-sm py-1 px-2 fw-semibold rounded-pill"
                                                                style="font-size: 0.72rem;" CommandName="EquipItem" CommandArgument='<%# Eval("id") + "|" + Eval("category") + "|" + Eval("image_url") + "|" + Eval("name") %>' />
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats 2x2 Grid (Right) -->
            <div class="col-lg-5">
                <div class="row g-3 h-100">
                    <!-- Stat 1: Level -->
                    <div class="col-6">
                        <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                            <div class="icon-box mx-auto mb-2" style="background:#EDE9FE; color:#7C3AED; width:44px; height:44px; font-size:1.25rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                                <i class="bi bi-mortarboard-fill"></i>
                            </div>
                            <div class="fs-4 fw-bold text-dark">Level <asp:Literal ID="litLevel2" runat="server" /></div>
                            <div class="text-muted small">Current Tier</div>
                        </div>
                    </div>

                    <!-- Stat 2: Coins -->
                    <div class="col-6">
                        <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                            <div class="icon-box mx-auto mb-2" style="background:#FEF3C7; color:#D97706; width:44px; height:44px; font-size:1.25rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                                <i class="bi bi-coin"></i>
                            </div>
                            <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litCoins" runat="server" /></div>
                            <div class="text-muted small">Virtual Coins</div>
                        </div>
                    </div>

                    <!-- Stat 3: Chapters/Exp -->
                    <div class="col-6">
                        <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                            <div class="icon-box mx-auto mb-2" style="background:#DCFCE7; color:#16A34A; width:44px; height:44px; font-size:1.25rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                                <i class="bi bi-bar-chart-line-fill"></i>
                            </div>
                            <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litExp" runat="server" /></div>
                            <div class="text-muted small">Level Progress</div>
                        </div>
                    </div>

                    <!-- Stat 4: Achievements -->
                    <div class="col-6">
                        <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                            <div class="icon-box mx-auto mb-2" style="background:#FCE7F3; color:#DB2777; width:44px; height:44px; font-size:1.25rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                                <i class="bi bi-trophy-fill"></i>
                            </div>
                            <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litAchievementsEarned" runat="server" /></div>
                            <div class="text-muted small">Achievements</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- MAIN SECTION: Left (Chapter Progress + Quiz + Simulation) | Right (Announcements Sidebar) -->
        <div class="row g-4">
            <!-- Left Main Column (8 cols) -->
            <div class="col-lg-8">
                <!-- 1. Chapter Progress (6 Stages) -->
                <div class="card border-0 shadow-sm mb-4 p-4" style="border-radius: 20px;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h2 class="h5 fw-bold text-dark mb-1"><i class="bi bi-journal-bookmark-fill text-primary me-2"></i>Chapter Progress</h2>
                            <p class="text-muted small mb-0">Complete all chapters and quizzes to unlock the next level.</p>
                        </div>
                        <a href="~/Pages/User/Lessons.aspx" class="btn btn-sm btn-outline-primary" runat="server">All Lessons</a>
                    </div>

                    <div class="list-group list-group-flush">
                        <asp:Repeater ID="rptProgress" runat="server">
                            <ItemTemplate>
                                <div class="list-group-item px-0 py-3 d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-2 border-bottom">
                                    <div class="d-flex align-items-center gap-3">
                                        <span class="badge rounded-pill px-3 py-2 fw-bold" style='<%# (int)Eval("is_completed") == 1 ? "background:#D1FAE5; color:#047857;" : (int)Eval("is_unlocked") == 1 ? "background:#EDE9FE; color:#6D28D9;" : "background:#F1F5F9; color:#64748B;" %>'>
                                            Level <%#: Eval("level_number") %>
                                        </span>
                                        <div>
                                            <div class="fw-bold text-dark"><%#: Eval("name") %></div>
                                            <div class="text-muted small"><%#: Eval("description") %></div>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <%# (int)Eval("is_completed") == 1
                                            ? "<span class='badge bg-success bg-opacity-10 text-success fw-bold px-3 py-2 rounded-pill'>&#10003; Completed</span>"
                                            : (int)Eval("is_unlocked") == 1
                                                ? "<a class='btn btn-sm btn-brand px-3' href='" + ResolveUrl("~/Pages/User/LessonList.aspx?categoryId=" + Eval("id")) + "'>In Progress &rarr;</a>"
                                                : "<span class='badge bg-secondary bg-opacity-10 text-secondary fw-semibold px-3 py-2 rounded-pill'>&#128274; Locked</span>" %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- 2. Recent Quiz Results (2-3 items) -->
                <div class="card border-0 shadow-sm mb-4 p-4" style="border-radius: 20px;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="h5 fw-bold text-dark mb-0"><i class="bi bi-patch-question-fill text-warning me-2"></i>Recent Quiz Results</h2>
                        <span class="badge bg-light text-muted border">Latest 3</span>
                    </div>
                    
                    <asp:Literal ID="litNoResults" runat="server" />
                    <div class="table-responsive">
                        <asp:Repeater ID="rptResults" runat="server">
                            <HeaderTemplate>
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Lesson / Chapter</th>
                                            <th>Score</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="fw-semibold text-dark"><%#: Eval("lesson_title") %></td>
                                    <td>
                                        <span class='<%# (int)Eval("score") >= 70 ? "badge bg-success" : "badge bg-warning text-dark" %>'>
                                            <%#: Eval("score") %>%
                                        </span>
                                    </td>
                                    <td class="text-muted small"><%#: Convert.ToDateTime(Eval("completed_at")).ToString("MMM d, yyyy") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- 3. Recent Simulation Results (2-3 items) -->
                <div class="card border-0 shadow-sm p-4" style="border-radius: 20px;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="h5 fw-bold text-dark mb-0"><i class="bi bi-controller text-info me-2"></i>Recent Simulation Decisions</h2>
                        <a href="~/Pages/User/Simulations.aspx" class="btn btn-sm btn-outline-primary" runat="server">Sandbox</a>
                    </div>

                    <asp:Literal ID="litNoSimResults" runat="server" />
                    <div class="table-responsive">
                        <asp:Repeater ID="rptSimResults" runat="server">
                            <HeaderTemplate>
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Simulation</th>
                                            <th>Decision Made</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="fw-semibold text-dark"><%#: Eval("simulation_title") %></td>
                                    <td class="text-secondary"><%#: Eval("decision") %></td>
                                    <td class="text-muted small"><%#: Convert.ToDateTime(Eval("completed_at")).ToString("MMM d, yyyy") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <!-- Right Sidebar Column (4 cols) -->
            <div class="col-lg-4">
                <!-- Announcements Widget -->
                <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 100px; border-radius: 20px;">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h2 class="h5 fw-bold text-dark mb-0 d-flex align-items-center gap-2">
                            <i class="bi bi-megaphone-fill text-primary"></i> Announcements
                        </h2>
                    </div>

                    <asp:Literal ID="litNoAnnouncements" runat="server" />

                    <div class="d-flex flex-column gap-3 mb-4">
                        <asp:Repeater ID="rptAnnouncements" runat="server">
                            <ItemTemplate>
                                <div class="p-3 rounded-4" style="background:#F8FAFC; border:1px solid #E2E8F0; border-left: 4px solid var(--color-primary);">
                                    <span class="badge bg-primary bg-opacity-10 text-primary fw-bold mb-2" style="font-size:0.7rem;">ANNOUNCEMENT</span>
                                    <h3 class="h6 fw-bold text-dark mb-1"><%#: Eval("title") %></h3>
                                    <p class="text-muted small mb-2"><%#: Eval("content") %></p>
                                    <div class="text-muted small" style="font-size:0.75rem;">
                                        <i class="bi bi-calendar3 me-1"></i><%#: Convert.ToDateTime(Eval("posted_at")).ToString("MMM d, yyyy") %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <a href="~/Pages/User/Announcements.aspx" class="btn btn-outline-brand w-100 py-2 fw-semibold text-center" runat="server">
                        See More Updates &rarr;
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

