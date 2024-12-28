# _plugins/pyodide_plugin.rb
module Jekyll
    class PyodideTag < Liquid::Block
      def initialize(tag_name, text, tokens)
        super
        @id = "pyodide-#{rand(1000..9999)}"
      end
  
      def render(context)
        code = super.strip
        <<~HTML
          <style>
            .CodeMirror {
              border: 1px solid #eee;
              height: auto;
            }
            .CodeMirror-scroll {
              max-height: 200px;
            }
          </style>
          <textarea id="#{@id}-code" rows="10" cols="50" style="width: 100%;">#{code}</textarea>
          <button id="#{@id}-runButton" onclick="runPython('#{@id}')" disabled>Run</button>
          <pre id="#{@id}-output"></pre>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/6.65.7/codemirror.min.css">
          <script src="https://cdn.jsdelivr.net/pyodide/v0.26.4/full/pyodide.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/6.65.7/codemirror.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/6.65.7/mode/python/python.min.js"></script>
          <script>
            async function loadPyodideAndPackages() {
              if (typeof window.pyodide === "undefined") {
                window.editors = [];
                window.pyodide = await loadPyodide({
                  indexURL: "https://cdn.jsdelivr.net/pyodide/v0.26.4/full/"
                });
              }
              window.editors["#{@id}-code"] = CodeMirror.fromTextArea(document.getElementById('#{@id}-code'), {
                mode: 'python',
                lineNumbers: true
                });
              document.getElementById('#{@id}-runButton').disabled = false;
            }
            loadPyodideAndPackages();
  
            if (typeof window.runPython === "undefined") {
              window.runPython = async function runPython(id) {
                let editor = window.editors[id + '-code'];
                let code = editor.getValue();
                let outputElement = document.getElementById(id + '-output');
                try {
                  let result = await pyodide.runPythonAsync(code);
                  outputElement.textContent = result;
                } catch (err) {
                  outputElement.textContent = err;
                }
              }
            }
          </script>
        HTML
      end
    end
  end
  
  Liquid::Template.register_tag('pyodide', Jekyll::PyodideTag)