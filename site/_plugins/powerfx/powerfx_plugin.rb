module Jekyll
    class PowerFxTag < Liquid::Block
      def initialize(tag_name, text, tokens)
        super
        @id = "powerfx-#{rand(1000..9999)}"
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
<button id="#{@id}-runButton" disabled>Run</button>
<div id="#{@id}-output"></div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.7/codemirror.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.7/codemirror.min.js"></script>
<script type="module">
import { dotnet } from '/powerfuldev-testing/powerfx/dotnet.js';

document.addEventListener('DOMContentLoaded', async function() {
   
    const { getAssemblyExports, getConfig } = await dotnet
    .withDiagnosticTracing(false)
    .create();

    const config = getConfig();
    const exports = await getAssemblyExports(config.mainAssemblyName);

    document.getElementById('#{@id}-runButton').disabled = false;

    async function executePowerFx(expression) {
        const result = exports.PowerFx.Execute(expression);
        document.getElementById("#{@id}-output").innerHTML = `Result: ${result}`;
    }

    const editor = CodeMirror.fromTextArea(document.getElementById('#{@id}-code'), {
        mode: 'javascript',
        lineNumbers: true
    });

    document.getElementById('#{@id}-runButton').addEventListener('click', function() {
        const expression = editor.getValue();
        executePowerFx(expression);
    });
});
</script>
        HTML
      end
    end
  end
  
  Liquid::Template.register_tag('powerfx', Jekyll::PowerFxTag)