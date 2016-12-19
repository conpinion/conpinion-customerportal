def cucumber_steps_replace_variables input, &post_processing
  input.gsub(/%{(\w+)}/) do
    key = Regexp.last_match[1]
    value = defined?(JsonSpec) ? JsonSpec.memory[key.to_sym].to_s : nil
    unless value
      value = self.instance_variable_get "@#{key}".to_sym
    end
    value = post_processing.call(value) if post_processing
    value
  end
end
