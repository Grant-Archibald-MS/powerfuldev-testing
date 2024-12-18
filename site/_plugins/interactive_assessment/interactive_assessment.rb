module Jekyll
    class InteractiveAssessmentTag < Liquid::Tag

        def initialize(tag_name, text, tokens)
        super
        @json_file = text.strip
        end

        # https://surveyjs.io/form-library/documentation/api-reference/survey-data-model

        def render(context)
<<-HTML
{% raw %}
<div id="surveyContainer"></div>
<link href="https://unpkg.com/survey-core/defaultV2.min.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="https://unpkg.com/survey-core/survey.core.min.js"></script>
<script type="text/javascript" src="https://unpkg.com/survey-js-ui/survey-js-ui.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
var elements = document.getElementsByTagName('p');

// Convert HTMLCollection to an array for easier manipulation
elements = Array.prototype.slice.call(elements);

// Loop through all <p> elements
elements.forEach(function(element) {
    // Check if the innerHTML matches the pattern
    if (element.innerHTML.trim() === '{% raw %}' || element.innerHTML.trim() === '{% endraw %}') {
        // Remove the element from the DOM
        element.remove();
    }
});
fetch('/powerfuldev-testing/assets/js/#{@json_file}')
.then(response => response.json())
.then(surveyJSON => {
    const survey = new Survey.Model(surveyJSON);
    survey.showTitle = false;
    survey.showCompleteButton = false;
    survey.render(document.getElementById("surveyContainer"));
    survey.onTextMarkdown.add((_, options) => {
        options.html = options.text;
    });
    survey.onAfterRenderQuestion.add(function (survey, options) {
    if (options.question.name === "matrixQuestion") {
        // Add event listener to all checkboxes within the matrix
        document.querySelectorAll('input[type="checkbox"][data-id]').forEach(function (checkbox) {
            checkbox.addEventListener('click', function () {
                let dataId = checkbox.getAttribute('data-id');
                survey.setValue(dataId, checkbox.checked);
                console.log('Checkbox clicked:', dataId, 'Value set to:', checkbox.checked);
            });
        });
    }
    });
    survey.onCurrentPageChanging.add(function (survey, options) {
        var oldPage = options.oldCurrentPage;
        var newPage = options.newCurrentPage;

        if (newPage.visibleIndex === 0) { // Check if the new page is the first page
            survey.pages.forEach(function (page) {
            page.questions.forEach(function (question) {
                question.clearValue();
            });
            });
        }
        else {
            if (newPage.visibleIndex < oldPage.visibleIndex) {
                oldPage.questions.forEach(function (q) {
                    q.clearValue();
                });
            }    
        }
    });
    
    survey.onValueChanged.add(function (survey, options) {
        var currentPageIndex = survey.currentPageNo;
        var visiblePages = survey.visiblePageCount;
        survey.pages.forEach(function (page, index) {
            if (index > currentPageIndex && index < visiblePages - 1) {
            page.questions.forEach(function (question) {
                question.clearValue();
            });
            }
        });
    });
})
.catch(error => console.error('Error loading survey questions:', error));
});
</script>
{% endraw %}
HTML
        end
    end
end
  
Liquid::Template.register_tag('interactive_assessment', Jekyll::InteractiveAssessmentTag)