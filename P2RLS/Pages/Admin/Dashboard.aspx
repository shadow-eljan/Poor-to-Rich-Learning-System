<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="P2RLS.Pages.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <asp:Literal ID="litAlert" runat="server" />

        <!-- 1. ADMIN HERO PROFILE & BANNER -->
        <div class="card card-no-hover p-0 mb-4 border-0 shadow-sm overflow-hidden" style="border-radius: 24px; background: #FFFFFF;">
            <!-- Custom Background Banner -->
            <div id="divBanner" runat="server" style="height: 200px; background: linear-gradient(135deg, #1E1B4B 0%, #3B0764 50%, #4C1D95 100%); background-size: cover; background-position: center; position: relative;">
                <div style="position: absolute; top: 16px; right: 16px;">
                    <span class="badge bg-dark bg-opacity-50 text-white fw-bold px-3 py-1 rounded-pill backdrop-blur">
                        <i class="bi bi-shield-lock-fill me-1 text-warning"></i> ADMIN CONTROL CENTER
                    </span>
                </div>
            </div>

            <!-- Profile Info Row: avatar overlaps banner bottom, name & buttons sit below -->
            <div class="px-4 pb-4" style="position: relative;">
                <!-- Avatar positioned to straddle the banner bottom -->
                <div style="margin-top: -55px; margin-bottom: 12px;">
                    <div class="position-relative d-inline-block" style="width: 110px; height: 110px;">
                        <asp:Image ID="imgAvatar" runat="server" CssClass="rounded-circle shadow-lg w-100 h-100"
                            style="object-fit: cover; border: 4px solid #FFFFFF; background: #EDE9FE;" Visible="false" />
                        <div id="divAvatarFallback" runat="server" class="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold shadow-lg w-100 h-100"
                            style="font-size: 2.4rem; background: linear-gradient(135deg, #7C3AED, #C026D3); border: 4px solid #FFFFFF;">
                            <asp:Literal ID="litAvatarInitial" runat="server" />
                        </div>
                        <!-- Border Frame Overlay (if equipped) -->
                        <asp:Image ID="imgAvatarBorder" runat="server" Visible="false"
                            style="position: absolute; top: -8px; left: -8px; width: 126px; height: 126px; pointer-events: none; object-fit: contain;" />
                    </div>
                </div>

                <!-- Name & Action Buttons — aligned on the same row -->
                <div class="d-flex align-items-center justify-content-between gap-3 flex-wrap mb-1">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-1">
                            <h1 class="h3 fw-bold text-dark mb-0"><asp:Literal ID="litUsername" runat="server" /></h1>
                            <span class="badge bg-primary rounded-pill px-3 py-1 fw-bold" style="font-size: 0.72rem;">ADMINISTRATOR</span>
                        </div>
                        <p class="text-muted small mb-0"><asp:Literal ID="litEmail" runat="server" /> &bull; Superuser Authority</p>
                    </div>

                    <!-- Action Buttons aligned with username -->
                    <div class="d-flex gap-2 align-items-center">
                        <button type="button" class="btn btn-outline-secondary btn-sm rounded-pill px-3 fw-semibold" data-bs-toggle="collapse" data-bs-target="#adminProfileCollapse">
                            <i class="bi bi-pencil-square me-1"></i> Edit Profile &amp; Cosmetics
                        </button>
                        <a href="~/Pages/User/Dashboard.aspx" class="btn btn-brand btn-sm rounded-pill px-4 fw-semibold" runat="server">
                            <i class="bi bi-eye-fill me-1"></i> Member View
                        </a>
                    </div>
                </div>

                <!-- COLLAPSED PROFILE SETTINGS: 2-Tab (Identity | Inventory) -->
                <div class="collapse mt-4 pt-4 border-top" id="adminProfileCollapse">
                    <div class="p-3 rounded-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                        <ul class="nav nav-pills mb-3" id="adminProfileTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active btn-sm rounded-pill px-3 fw-bold" id="admin-identity-tab"
                                    data-bs-toggle="tab" data-bs-target="#admin-identity-pane" type="button" role="tab">
                                    Identity &amp; Uploads
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link btn-sm rounded-pill px-3 fw-bold" id="admin-inventory-tab"
                                    data-bs-toggle="tab" data-bs-target="#admin-inventory-pane" type="button" role="tab">
                                    Owned Cosmetics &amp; Frames
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="adminProfileTabContent">
                            <!-- Tab 1: Identity -->
                            <div class="tab-pane fade show active" id="admin-identity-pane" role="tabpanel">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label class="form-label small fw-bold text-dark">Admin Display Name</label>
                                        <asp:TextBox ID="txtNewUsername" runat="server" CssClass="form-control form-control-sm" MaxLength="50" />
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label small fw-bold text-dark">Upload Profile Avatar (PNG/JPG)</label>
                                        <asp:FileUpload ID="fuAvatar" runat="server" CssClass="form-control form-control-sm" accept=".png,.jpg,.jpeg,.webp,.gif" />
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label small fw-bold text-dark">Upload Profile Background Banner</label>
                                        <asp:FileUpload ID="fuBanner" runat="server" CssClass="form-control form-control-sm" accept=".png,.jpg,.jpeg,.webp,.gif" />
                                    </div>
                                </div>
                                <div class="mt-3 text-end">
                                    <asp:Button ID="btnSaveProfile" runat="server" Text="Save Identity Changes"
                                        CssClass="btn btn-brand btn-sm rounded-pill px-4 fw-bold" OnClick="btnSaveProfile_Click" />
                                </div>
                            </div>

                            <!-- Tab 2: Owned Cosmetics (Discord-style equip) -->
                            <div class="tab-pane fade" id="admin-inventory-pane" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="small text-muted fw-semibold">Click Equip to apply an item you bought from the Reward Shop:</span>
                                    <a href="~/Pages/User/RewardShop.aspx" class="small fw-bold text-primary" runat="server">Open Shop &rarr;</a>
                                </div>
                                <asp:Literal ID="litNoInventory" runat="server" />
                                <div class="row g-2">
                                    <asp:Repeater ID="rptInventory" runat="server" OnItemCommand="rptInventory_ItemCommand">
                                        <ItemTemplate>
                                            <div class="col-sm-6 col-md-4">
                                                <div class="p-2 rounded-3 bg-white border d-flex align-items-center justify-content-between gap-2 shadow-sm">
                                                    <div class="d-flex align-items-center gap-2 overflow-hidden">
                                                        <%# RenderCosmeticIcon(Eval("category"), Eval("image_url"), Eval("name")) %>
                                                        <div class="overflow-hidden">
                                                            <div class="small fw-bold text-truncate text-dark"><%# Eval("name") %></div>
                                                            <%# RenderCategoryBadge(Eval("category")) %>
                                                        </div>
                                                    </div>
                                                    <asp:Button ID="btnEquip" runat="server" Text="Equip"
                                                        CssClass="btn btn-outline-primary btn-sm py-1 px-2 fw-semibold rounded-pill"
                                                        style="font-size:0.72rem;"
                                                        CommandName="EquipItem"
                                                        CommandArgument='<%# Eval("id") + "|" + Eval("category") + "|" + Eval("image_url") + "|" + Eval("name") %>' />
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

        <!-- 2. PLATFORM KPI METRICS (6 Cards) -->
        <div class="row g-3 mb-4">
            <!-- Metric 1: Total Users -->
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                    <div class="icon-box mx-auto mb-2" style="background:#EDE9FE; color:#7C3AED; width:42px; height:42px; font-size:1.2rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litTotalUsers" runat="server" Text="0" /></div>
                    <div class="text-muted small">Total Users</div>
                </div>
            </div>

            <!-- Metric 2: Active Learners -->
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                    <div class="icon-box mx-auto mb-2" style="background:#DCFCE7; color:#16A34A; width:42px; height:42px; font-size:1.2rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                        <i class="bi bi-person-check-fill"></i>
                    </div>
                    <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litActiveUsers" runat="server" Text="0" /></div>
                    <div class="text-muted small">Active Members</div>
                </div>
            </div>

            <!-- Metric 3: Lessons & Stages -->
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                    <div class="icon-box mx-auto mb-2" style="background:#E0F2FE; color:#0284C7; width:42px; height:42px; font-size:1.2rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                        <i class="bi bi-journal-bookmark-fill"></i>
                    </div>
                    <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litTotalLessons" runat="server" Text="0" /></div>
                    <div class="text-muted small">Total Chapters</div>
                </div>
            </div>

            <!-- Metric 4: MCQ Quizzes -->
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                    <div class="icon-box mx-auto mb-2" style="background:#FEF3C7; color:#D97706; width:42px; height:42px; font-size:1.2rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                        <i class="bi bi-patch-question-fill"></i>
                    </div>
                    <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litTotalQuizzes" runat="server" Text="0" /></div>
                    <div class="text-muted small">Quiz Questions</div>
                </div>
            </div>

            <!-- Metric 5: Simulations -->
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                    <div class="icon-box mx-auto mb-2" style="background:#FCE7F3; color:#DB2777; width:42px; height:42px; font-size:1.2rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                        <i class="bi bi-controller"></i>
                    </div>
                    <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litTotalSimulations" runat="server" Text="0" /></div>
                    <div class="text-muted small">Simulations</div>
                </div>
            </div>

            <!-- Metric 6: Virtual Economy -->
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card h-100 p-3 border-0 shadow-sm text-center" style="border-radius: 18px; background: #FFFFFF;">
                    <div class="icon-box mx-auto mb-2" style="background:#FEF9C3; color:#CA8A04; width:42px; height:42px; font-size:1.2rem; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;">
                        <i class="bi bi-coin"></i>
                    </div>
                    <div class="fs-4 fw-bold text-dark"><asp:Literal ID="litTotalCoinsEconomy" runat="server" Text="0" /></div>
                    <div class="text-muted small">Coins in Economy</div>
                </div>
            </div>
        </div>

        <!-- 3. BENTO GRID: 8 MANAGEMENT MODULES -->
        <div class="row g-4 mb-4">
            <!-- 1. Lesson Categories (6 Levels) -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box-purple rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem;">
                            <i class="bi bi-diagram-3-fill"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">6 Stages / Levels</h2>
                        <p class="text-muted small mb-3">Manage main stages (Survival to Financial Freedom), time estimates, and images.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/LessonCategories.aspx" runat="server">
                        Manage Levels &rarr;
                    </a>
                </div>
            </div>

            <!-- 2. Lessons & Chapters -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem; background:#EDE9FE; color:#7C3AED; display:inline-flex; align-items:center; justify-content:center;">
                            <i class="bi bi-journal-text"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">Lessons &amp; Chapters</h2>
                        <p class="text-muted small mb-3">Create chapters with rich markdown, key takeaways, and quotes.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/Lessons.aspx" runat="server">
                        Manage Lessons &rarr;
                    </a>
                </div>
            </div>

            <!-- 3. Quiz Questions Builder -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem; background:#FEF3C7; color:#D97706; display:inline-flex; align-items:center; justify-content:center;">
                            <i class="bi bi-patch-question-fill"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">MCQ Quiz Builder</h2>
                        <p class="text-muted small mb-3">Configure 4-choice questions, correct answer keys, and coin rewards.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/QuizQuestions.aspx" runat="server">
                        Manage Quizzes &rarr;
                    </a>
                </div>
            </div>

            <!-- 4. Financial Simulations -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem; background:#E0F2FE; color:#0284C7; display:inline-flex; align-items:center; justify-content:center;">
                            <i class="bi bi-controller"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">Simulations</h2>
                        <p class="text-muted small mb-3">Design interactive scenarios, choices, and realistic consequences.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/FinancialSimulations.aspx" runat="server">
                        Manage Scenarios &rarr;
                    </a>
                </div>
            </div>

            <!-- 5. Reward Store & Asset Uploads -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem; background:#DCFCE7; color:#16A34A; display:inline-flex; align-items:center; justify-content:center;">
                            <i class="bi bi-shop"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">Shop &amp; Cosmetics</h2>
                        <p class="text-muted small mb-3">Upload custom avatars, background banners, and animated frames.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/RewardItems.aspx" runat="server">
                        Manage Shop &rarr;
                    </a>
                </div>
            </div>

            <!-- 6. Platform Announcements -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem; background:#FCE7F3; color:#DB2777; display:inline-flex; align-items:center; justify-content:center;">
                            <i class="bi bi-megaphone-fill"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">Announcements</h2>
                        <p class="text-muted small mb-3">Broadcast notices, feature releases, and updates to members.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/Announcements.aspx" runat="server">
                        Manage News &rarr;
                    </a>
                </div>
            </div>

            <!-- 7. Achievements -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem; background:#FEF9C3; color:#CA8A04; display:inline-flex; align-items:center; justify-content:center;">
                            <i class="bi bi-trophy-fill"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">Achievements</h2>
                        <p class="text-muted small mb-3">Define badge milestones, thresholds, and unlock coin bonuses.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/Achievements.aspx" runat="server">
                        Manage Badges &rarr;
                    </a>
                </div>
            </div>

            <!-- 8. User Management -->
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between" style="border-radius: 20px; background: #FFFFFF;">
                    <div>
                        <div class="icon-box rounded-4 mb-3" style="width: 48px; height: 48px; font-size: 1.4rem; background:#F1F5F9; color:#475569; display:inline-flex; align-items:center; justify-content:center;">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <h2 class="h5 fw-bold text-dark mb-1">Users &amp; Roles</h2>
                        <p class="text-muted small mb-3">View directory of registered members, promote admins, or prune accounts.</p>
                    </div>
                    <a class="btn btn-outline-brand w-100 fw-semibold rounded-pill" href="~/Pages/Admin/Users.aspx" runat="server">
                        Manage Users &rarr;
                    </a>
                </div>
            </div>
        </div>

        <!-- 4. RECENT USERS DIRECTORY PREVIEW -->
        <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h2 class="h5 fw-bold text-dark mb-1"><i class="bi bi-person-lines-fill text-primary me-2"></i>Recent Registered Learners</h2>
                    <p class="text-muted small mb-0">Live roster of newly joined platform users.</p>
                </div>
                <a href="~/Pages/Admin/Users.aspx" class="btn btn-sm btn-outline-primary rounded-pill px-3" runat="server">
                    View Full Directory &rarr;
                </a>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvRecentUsers" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false">
                    <HeaderStyle CssClass="table-light text-muted small fw-bold" />
                    <Columns>
                        <asp:BoundField DataField="username" HeaderText="Username" ItemStyle-CssClass="fw-bold text-dark" />
                        <asp:BoundField DataField="email" HeaderText="Email Address" ItemStyle-CssClass="text-muted small" />
                        <asp:BoundField DataField="role" HeaderText="Role" ItemStyle-CssClass="text-primary fw-semibold" />
                        <asp:BoundField DataField="level" HeaderText="Level" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="virtual_coins" HeaderText="Coins" ItemStyle-CssClass="fw-bold text-warning" />
                        <asp:BoundField DataField="created_at" HeaderText="Date Joined" DataFormatString="{0:MMM d, yyyy}" ItemStyle-CssClass="text-muted small" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>


