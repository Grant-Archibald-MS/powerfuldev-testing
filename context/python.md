# Python Sample

These samples make use of executing Python in the browser using pyioide. You can use these skills to allow you to use you python skills and make use of them in web pages and inside the extension points of the Power Platform.

Lets look at some examples.

## Integers

{% pyodide %}
1 + 1
{% endpyodide %}

## String

{% pyodide %}
"a" + "b"
{% endpyodide %}

## Functions

{% pyodide %}
def hello(name):
  return "Hello " + name

hello("World!")
{% endpyodide %}
