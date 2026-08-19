using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using P2RLS.DAL;
using P2RLS.Common;

namespace P2RLS.Pages.Admin
{
    public partial class QuizQuestionEdit : AdminBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            BindLessonDropdown();

            // Pre-select lesson from querystring (e.g. coming from Lessons list)
            string qsLesson = Request.QueryString["lessonId"];
            if (!string.IsNullOrEmpty(qsLesson) && ddlLesson.Items.FindByValue(qsLesson) != null)
                ddlLesson.SelectedValue = qsLesson;

            EmitExistingQuestions();
        }

        private void BindLessonDropdown()
        {
            var lessons = QuizQuestionDAL.GetLessonsForDropdown();
            ddlLesson.DataSource = lessons;
            ddlLesson.DataTextField = "title";
            ddlLesson.DataValueField = "id";
            ddlLesson.DataBind();

            if (ddlLesson.Items.Count == 0)
                litError.Text = "<div class='alert alert-warning'>No lessons exist yet. Create a lesson first.</div>";
        }

        // Called when the lesson dropdown changes (AutoPostBack) — reloads questions
        protected void ddlLesson_Changed(object sender, EventArgs e)
        {
            EmitExistingQuestions();
        }

        // Emits existing questions for the selected lesson as a hidden JSON span
        // so the client-side JS can pre-fill the question cards.
        private void EmitExistingQuestions()
        {
            if (ddlLesson.Items.Count == 0) return;

            int lessonId;
            if (!int.TryParse(ddlLesson.SelectedValue, out lessonId)) return;

            DataTable dt = QuizQuestionDAL.GetByLesson(lessonId);
            var jss = new JavaScriptSerializer();
            var list = new List<object>();

            foreach (DataRow row in dt.Rows)
            {
                var opts = jss.Deserialize<List<string>>(row["options"].ToString());
                list.Add(new
                {
                    questionText = row["question_text"].ToString(),
                    options = opts,
                    correctAnswer = row["correct_answer"].ToString()
                });
            }

            string json = jss.Serialize(list);
            // Output as a hidden span with a data-json attribute; JS reads it on DOMContentLoaded
            litExistingJson.Text = string.Format(
                "<span id='_existingQData' data-json='{0}' style='display:none'></span>",
                json.Replace("'", "&#39;"));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlLesson.Items.Count == 0) return;

            int lessonId;
            if (!int.TryParse(ddlLesson.SelectedValue, out lessonId)) return;

            string json = hdnQuestionsJson.Value;
            if (string.IsNullOrWhiteSpace(json))
            {
                litError.Text = "<div class='alert alert-danger'>No questions were submitted. Please add at least one question.</div>";
                EmitExistingQuestions();
                return;
            }

            var jss = new JavaScriptSerializer();
            List<Dictionary<string, object>> questions;
            try
            {
                questions = jss.Deserialize<List<Dictionary<string, object>>>(json);
            }
            catch
            {
                litError.Text = "<div class='alert alert-danger'>Invalid submission data. Please try again.</div>";
                EmitExistingQuestions();
                return;
            }

            // Replace all questions for this lesson atomically
            QuizQuestionDAL.DeleteAllForLesson(lessonId);

            foreach (var q in questions)
            {
                string questionText = q.ContainsKey("questionText") ? q["questionText"].ToString() : "";
                string correctAnswer = q.ContainsKey("correctAnswer") ? q["correctAnswer"].ToString() : "";

                // options comes back as ArrayList from JavaScriptSerializer
                var rawOpts = q.ContainsKey("options") ? q["options"] as System.Collections.ArrayList : null;
                var opts = new List<string>();
                if (rawOpts != null)
                    foreach (var o in rawOpts) opts.Add(o.ToString());

                if (string.IsNullOrWhiteSpace(questionText) || opts.Count < 2) continue;

                string optionsJson = jss.Serialize(opts);
                QuizQuestionDAL.Insert(lessonId, questionText, optionsJson, correctAnswer);
            }

            Response.Redirect("~/Pages/Admin/QuizQuestions.aspx");
        }
    }
}