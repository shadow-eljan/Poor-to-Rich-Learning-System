<%@ Page Title="Quiz" Language="C#" MasterPageFile="~/Pages/Shared/Site.master" AutoEventWireup="true" CodeBehind="QuizTake.aspx.cs" Inherits="P2RLS.Pages.User.QuizTake" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 max-w-800 mx-auto">
        <!-- Top Header & Navigation -->
        <div class="mb-4">
            <a id="lnkBackToLesson" runat="server" class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-3">
                &larr; Back to Lesson
            </a>
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-2">
                <div>
                    <span class="badge badge-brand text-uppercase px-3 py-1 mb-1 rounded-pill fw-bold" style="font-size: 0.72rem;">
                        KNOWLEDGE CHECK
                    </span>
                    <h1 class="h3 fw-bold text-dark mb-0"><asp:Literal ID="litLessonTitle" runat="server" /></h1>
                </div>
                <div>
                    <span class="badge bg-light text-muted border px-3 py-2 rounded-pill fw-semibold">
                        <asp:Literal ID="litDifficulty" runat="server" />
                    </span>
                </div>
            </div>
        </div>

        <asp:Literal ID="litMessage" runat="server" />

        <!-- Quiz Questions Form -->
        <asp:Panel ID="pnlQuiz" runat="server">
            <asp:Repeater ID="rptQuestions" runat="server" OnItemDataBound="rptQuestions_ItemDataBound">
                <ItemTemplate>
                    <div class="card p-4 p-md-5 mb-4 border-0 shadow-sm" style="border-radius: 20px; background: #FFFFFF;">
                        <asp:HiddenField ID="hdnQuestionId" runat="server" Value='<%# Eval("id") %>' />
                        
                        <!-- Question Text starting from left -->
                        <div class="fw-bold text-dark fs-5 mb-4 text-start" style="line-height: 1.5;">
                            <span class="text-primary me-2">Q<%# Container.ItemIndex + 1 %>.</span><%#: Eval("question_text") %>
                        </div>

                        <!-- Custom A/B/C/D Option Cards -->
                        <div class="quiz-options-group">
                            <asp:Literal ID="litOptionsHtml" runat="server" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Bottom Action Button (No hint, right aligned Check Answer) -->
            <div class="d-flex justify-content-end align-items-center pt-3 border-top mt-4 mb-5">
                <asp:Button ID="btnSubmit" runat="server" Text="Check Answer" 
                    CssClass="btn btn-brand px-5 py-3 fw-bold rounded-pill shadow-sm" 
                    OnClick="btnSubmit_Click" />
            </div>
        </asp:Panel>
    </div>

    <!-- Client-side Interactive Option Selection Script -->
    <script type="text/javascript">
        function selectQuizOption(cardElement) {
            var parent = cardElement.closest('.quiz-options-group');
            if (parent) {
                var allCards = parent.querySelectorAll('.quiz-option-card');
                for (var i = 0; i < allCards.length; i++) {
                    allCards[i].classList.remove('selected');
                }
            }
            cardElement.classList.add('selected');
            var radio = cardElement.querySelector('input[type="radio"]');
            if (radio) {
                radio.checked = true;
            }
        }
    </script>
</asp:Content>

