module Jekyll
    class PowerFxPlaygroundTag < Liquid::Block
      def initialize(tag_name, text, tokens)
        super
        @id = "powerfx-#{rand(1000..9999)}"
        @button_text = text.strip.empty? ? "Try It!" : text.strip
        @file_hash = 'UNKNOWN'
      end

      def generate(site)
        site.static_files.each do |file|
            next unless file.extname == '.yaml' # Specify your file extension
    
            file_path = file.path
            file_hash = Digest::SHA256.file(file_path).hexdigest
    
            # Store the hash in a data file or use it as needed
            site.data['file_hashes'] ||= {}
            site.data['file_hashes'][file.name] = file_hash
        end
        @file_hash = site.data.file_hashes['playgrounds.yaml']
      end
  
      def render(context)
        <<~HTML
  <style>
    .monaco-editor {
      border: 1px solid #eee;
      height: auto;
    }
    .page { 
      float: none !important;
      width: 100%;
    }
  </style>
  <div id="#{@id}-title"></div>
  <div id="#{@id}-description"></div>
  <div id="#{@id}-editor" style="width: 100%; height: 200px"></div>
  <button id="#{@id}-runButton" disabled>#{@button_text}</button>
  <button id="#{@id}-resetButton">Reset</button>
  <button id="#{@id}-openRelatedButton" disabled>Open Related Task</button>
  <select id="#{@id}-relatedTasksDropdown">
    <option value="">Select a related task</option>
  </select>
  <div id="#{@id}-output"></div>
  <div id="#{@id}-steps"></div>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs/editor/editor.main.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs/loader.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/yamljs@0.3.0/dist/yaml.min.js"></script>
  <script>
      const base = document.createElement('base');
      base.href = '/powerfuldev-testing/';
      document.head.appendChild(base);
  </script>
  <script src="/powerfuldev-testing/_framework/blazor.webassembly.js" autostart="false"></script>
  <script>
  document.addEventListener('DOMContentLoaded', async function() {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const playgroundTitle = urlParams.get('title');
  
    const data = YAML.load('/powerfuldev-testing/assets/playgrounds.yaml');
    const playground = playgroundTitle ? data.playgrounds.find(p => p.shortId === playgroundTitle) : null;
  
    if (playground) {
      const { title, description, code, steps, relatedTasks } = playground;
  
      Blazor.start({
        loadBootResource: function (type, name, defaultUri, integrity) {
          console.log(defaultUri)
        }
      }).then(async () => {
          var r = Blazor.runtime
          const exports = await r.getAssemblyExports(r.config.mainAssemblyName);
          document.getElementById('#{@id}-runButton').addEventListener('click', function() {
            const expression = window.editor.getValue();
            const result = exports.PowerFx.Execute(expression);
            document.getElementById("#{@id}-output").innerHTML = `Result: ${result}`;
          });
          document.getElementById('#{@id}-runButton').disabled = false;
        })
  
      require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.52.2/min/vs' }});
      require(['vs/editor/editor.main'], function() {
        window.editor = monaco.editor.create(document.getElementById('#{@id}-editor'), {
          value: code,
          language: 'javascript',
          automaticLayout: true,
          minimap: { enabled: false } // Disable the minimap
        });
      });

      document.getElementById('#{@id}-title').innerHTML = markdown.toHTML(`## ${title}`);
      document.getElementById('#{@id}-description').innerHTML = markdown.toHTML(description);
  
      // Convert markdown steps to HTML and display
      const stepsHtml = markdown.toHTML(steps);
      document.getElementById('#{@id}-steps').innerHTML = stepsHtml;
  
      // Populate related tasks dropdown
      const dropdown = document.getElementById('#{@id}-relatedTasksDropdown');
      relatedTasks.forEach(taskId => {
        var relatedPlayground = data.playgrounds.find(p => p.shortId === taskId);
        if (relatedPlayground) {
          const option = document.createElement('option');
          option.value = taskId;
          option.text = `${relatedPlayground.title}`;
          dropdown.appendChild(option);
        }
      });
  
      // Enable the open related button when a related task is selected
      dropdown.addEventListener('change', function() {
        const selectedTaskId = dropdown.value;
        document.getElementById('#{@id}-openRelatedButton').disabled = !selectedTaskId;
      });
  
      // Add event listener to open related task in new page
      document.getElementById('#{@id}-openRelatedButton').addEventListener('click', function() {
        const selectedTaskId = dropdown.value;
        if (selectedTaskId) {
          const currentUrl = new URL(window.location.href);
          currentUrl.searchParams.set('title', selectedTaskId);
          window.open(currentUrl.toString(), '_blank');
        }
      });
  
      // Add event listener to reset button
      document.getElementById('#{@id}-resetButton').addEventListener('click', function() {
        window.location.reload();
      });
    }
  });
  </script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/js-yaml/4.1.0/js-yaml.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/markdown/lib/markdown.js"></script>
        HTML
      end
    end
  end
  
  Liquid::Template.register_tag('powerfx_playground', Jekyll::PowerFxPlaygroundTag)