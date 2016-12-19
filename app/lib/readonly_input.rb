class ReadonlyInput < FormtasticBootstrap::Inputs::StringInput
  def to_html
    input_wrapping do
      label_html << object.send(method)
    end
  end
end
