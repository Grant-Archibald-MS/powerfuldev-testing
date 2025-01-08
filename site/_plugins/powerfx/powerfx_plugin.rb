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
  .monaco-editor {
    border: 1px solid #eee;
    height: auto;
  }
</style>
<div id="#{@id}-editor" style="width: 100%; height: 200px;"></div>
<button id="#{@id}-runButton" disabled>Try It!</button>
<div id="#{@id}-output"></div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs/editor/editor.main.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs/loader.js"></script>
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

  require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs' }});
  require(['vs/editor/editor.main'], function() {
    const editor = monaco.editor.create(document.getElementById('#{@id}-editor'), {
      value: `#{code}`,
      language: 'javascript',
      automaticLayout: true,
      minimap: { enabled: false } // Disable the minimap
    });

    document.getElementById('#{@id}-runButton').addEventListener('click', function() {
      const expression = editor.getValue();
      executePowerFx(expression);
    });
  });
});
</script>
      HTML
    end
  end
end

Liquid::Template.register_tag('powerfx', Jekyll::PowerFxTag)