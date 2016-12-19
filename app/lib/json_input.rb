class JsonInput < FormtasticBootstrap::Inputs::TextInput
  def to_html
    bootstrap_wrapping do
      opts = form_control_input_html_options.merge({
        class: 'codemirror',
        data: { 'codemirror-mode': 'javascript' }
      })
      builder.text_area "#{method}_json", opts
    end
  end
end
