<%@ Page Title="Quiz Question Builder" Language="C#" MasterPageFile="~/Pages/Shared/Site.master"
    AutoEventWireup="true" CodeBehind="QuizQuestionEdit.aspx.cs" Inherits="P2RLS.Pages.Admin.QuizQuestionEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container py-4 max-w-900 mx-auto">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="h3 fw-bold text-dark mb-1">Quiz Question Builder</h1>
            <p class="text-muted mb-0">Select a chapter lesson, add knowledge check questions, and set the correct answers.</p>
        </div>
        <a class="btn btn-outline-secondary btn-sm rounded-pill px-3" href="~/Pages/Admin/QuizQuestions.aspx" runat="server">
            &larr; Back to Questions
        </a>
    </div>

    <asp:Literal ID="litError" runat="server" />

    <%-- Lesson selector --%>
    <div class="card p-4 border-0 shadow-sm mb-4" style="border-radius: 20px; background: #FFFFFF;">
        <label for="<%= ddlLesson.ClientID %>" class="form-label fw-bold small text-dark">Associated Chapter Lesson</label>
        <asp:DropDownList ID="ddlLesson" runat="server" CssClass="form-select" style="max-width: 400px;"
            AutoPostBack="true" OnSelectedIndexChanged="ddlLesson_Changed" />
        <small class="text-muted mt-1">Changing the lesson reloads its existing questions.</small>
    </div>

    <%-- Hidden field: JSON of all question cards, written by JS just before postback --%>
    <asp:HiddenField ID="hdnQuestionsJson" runat="server" />

    <%-- Cards rendered here by JS --%>
    <div id="questionsContainer"></div>

    <div class="d-flex gap-3 mt-3 mb-5">
        <button type="button" class="btn btn-outline-primary rounded-pill px-4 fw-semibold" onclick="addQuestion()">&#43; Add Question</button>
        <asp:Button ID="btnSave" runat="server" Text="Save All Questions" CssClass="btn btn-brand rounded-pill px-5 fw-bold"
            OnClientClick="return prepareSubmit();" OnClick="btnSave_Click" />
        <a class="btn btn-outline-secondary rounded-pill px-4" href="~/Pages/Admin/QuizQuestions.aspx" runat="server">Cancel</a>
    </div>
</div>

<%-- Card template (hidden, cloned by JS) --%>
<template id="qCardTpl">
    <div class="card mb-3 q-card border-0 shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <strong class="q-num"></strong>
                <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeCard(this)">Remove</button>
            </div>
            <div class="mb-3">
                <label class="form-label">Question Text</label>
                <textarea class="form-control q-text" rows="2" placeholder="Enter your question..."></textarea>
            </div>
            <label class="form-label">Options &mdash; select the correct answer</label>
            <div class="opt-row input-group mb-2">
                <span class="input-group-text"><input type="radio" name="r_PLACEHOLDER" value="0" title="Correct answer"></span>
                <input type="text" class="form-control q-opt" placeholder="Option 1">
            </div>
            <div class="opt-row input-group mb-2">
                <span class="input-group-text"><input type="radio" name="r_PLACEHOLDER" value="1" title="Correct answer"></span>
                <input type="text" class="form-control q-opt" placeholder="Option 2">
            </div>
            <div class="opt-row input-group mb-2">
                <span class="input-group-text"><input type="radio" name="r_PLACEHOLDER" value="2" title="Correct answer"></span>
                <input type="text" class="form-control q-opt" placeholder="Option 3 (optional)">
            </div>
            <div class="opt-row input-group mb-0">
                <span class="input-group-text"><input type="radio" name="r_PLACEHOLDER" value="3" title="Correct answer"></span>
                <input type="text" class="form-control q-opt" placeholder="Option 4 (optional)">
            </div>
        </div>
    </div>
</template>

<%-- Server passes existing questions as a data attribute on a hidden span --%>
<asp:Literal ID="litExistingJson" runat="server" />

<script>
    var _uid = 0;

    function addQuestion(data) {
        _uid++;
        var tpl = document.getElementById('qCardTpl');
        var frag = tpl.content.cloneNode(true);
        var card = frag.querySelector('.q-card');

        // Unique radio name per card so only one can be selected per card
        card.querySelectorAll('input[type=radio]').forEach(function(r) {
            r.name = r.name.replace('PLACEHOLDER', _uid);
        });

        if (data) {
            card.querySelector('.q-text').value = data.questionText || '';
            var opts = data.options || [];
            var oInputs = card.querySelectorAll('.q-opt');
            oInputs.forEach(function(inp, i) { inp.value = opts[i] || ''; });

            var correctIdx = opts.indexOf(data.correctAnswer);
            if (correctIdx >= 0) {
                var radios = card.querySelectorAll('input[type=radio]');
                if (radios[correctIdx]) radios[correctIdx].checked = true;
            }
        }

        document.getElementById('questionsContainer').appendChild(frag);
        renumber();
    }

    function removeCard(btn) {
        btn.closest('.q-card').remove();
        renumber();
    }

    function renumber() {
        document.querySelectorAll('.q-card .q-num').forEach(function(el, i) {
            el.textContent = 'Question ' + (i + 1);
        });
    }

    function prepareSubmit() {
        var cards = document.querySelectorAll('.q-card');
        if (!cards.length) { alert('Add at least one question.'); return false; }

        var questions = [], ok = true;
        cards.forEach(function(card, idx) {
            if (!ok) return;
            var n = idx + 1;
            var text = card.querySelector('.q-text').value.trim();
            if (!text) { alert('Question ' + n + ': question text is required.'); ok = false; return; }

            var allOpts = card.querySelectorAll('.q-opt');
            var opts = [];
            allOpts.forEach(function(i) { if (i.value.trim()) opts.push(i.value.trim()); });
            if (opts.length < 2) { alert('Question ' + n + ': at least 2 options required.'); ok = false; return; }

            var sel = card.querySelector('input[type=radio]:checked');
            if (!sel) { alert('Question ' + n + ': select the correct answer.'); ok = false; return; }

            var allVals = [];
            allOpts.forEach(function(i) { allVals.push(i.value.trim()); });
            var correctText = allVals[parseInt(sel.value)] || opts[0];

            questions.push({ questionText: text, options: opts, correctAnswer: correctText });
        });

        if (!ok) return false;
        document.getElementById('<%= hdnQuestionsJson.ClientID %>').value = JSON.stringify(questions);
        return true;
    }

    document.addEventListener('DOMContentLoaded', function() {
        var src = document.getElementById('_existingQData');
        var loaded = false;
        if (src) {
            try {
                var arr = JSON.parse(src.getAttribute('data-json') || '[]');
                arr.forEach(function(q) { addQuestion(q); loaded = true; });
            } catch(e) {}
        }
        if (!loaded) addQuestion(); // start with one blank card
    });
</script>
</asp:Content>
