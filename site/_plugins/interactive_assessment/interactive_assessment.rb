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
    console.log(surveyJSON);
    const survey = new Survey.Model(surveyJSON);
    survey.showTitle = false;
    survey.showCompleteButton = false;
    survey.render(document.getElementById("surveyContainer"));
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