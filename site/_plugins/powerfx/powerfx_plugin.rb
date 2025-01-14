module Jekyll
  class PowerFxTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @id = "powerfx-#{rand(1000..9999)}"
      @button_text = text.strip.empty? ? "Try It!" : text.strip
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
<button id="#{@id}-runButton" disabled>#{@button_text}</button>
<div id="#{@id}-output"></div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs/editor/editor.main.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs/loader.js"></script>
<script>
    const base = document.createElement('base');
    base.href = '/powerfuldev-testing/';
    document.head.appendChild(base);
</script>
<script src="/powerfuldev-testing/_framework/blazor.webassembly.js" autostart="false"></script>
<script>
document.addEventListener('DOMContentLoaded', async function() {
  Blazor.start({
    loadBootResource: function (type, name, defaultUri, integrity) {
      console.log(defaultUri)
    }
  }).then(async () => {
      var r = Blazor.runtime
      const exports = await r.getAssemblyExports(r.config.mainAssemblyName);
      document.getElementById('#{@id}-runButton').addEventListener('click', function() {
        const expression = window.editor.getValue();
        const result = exports.PowerFxEngine.Execute(expression);
        document.getElementById("#{@id}-output").innerHTML = `Result: ${result}`;
      });
      document.getElementById('#{@id}-runButton').disabled = false;
    })

  require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs' }});
  require(['vs/editor/editor.main'], function() {
    window.editor = monaco.editor.create(document.getElementById('#{@id}-editor'), {
      value: `#{code}`,
      language: 'javascript',
      automaticLayout: true,
      minimap: { enabled: false } // Disable the minimap
    });
  });
});
</script>
      HTML
    end
  end
end

Liquid::Template.register_tag('powerfx', Jekyll::PowerFxTag)