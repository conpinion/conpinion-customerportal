module NavigationHelper
  def awesome_link_to text, icon, to, options = {}
    hide_text = options.delete(:hide_text)
    options[:title] ||= text
    link_to to, options do
      concat content_tag :i, '', class: "fa fa-#{icon}"
      concat content_tag 'span', text unless hide_text
    end
  end

  def action_to text, icon, to, options = {}
    options[:title] ||= text
    options[:class] ||= 'btn btn-xs'
    color = options[:color] ? "text-#{options[:color]}" : ''
    link_to to, options do
      concat content_tag :i, '', class: "fa fa-#{icon} #{color}"
    end
  end

  def link_to_back label = t('actions.back')
    link_to label, 'javascript:history.go(-1);', class: 'btn btn-default'
  end
end
