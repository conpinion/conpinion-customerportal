module SearchHelper
  def search_form_buttons
    (button_tag '', class: 'btn btn-sm btn-warning',
      onclick: '$(this.form).clearForm();' do
      content_tag :i, '', class: 'fa fa-remove'
    end) +
      (button_tag '', class: 'btn btn-sm btn-success' do
        content_tag :i, '', class: 'fa fa-search'
      end)
  end

  def search_form_field form, name, placeholder
    content_tag :div, class: 'input-group' do
      form.search_field(name, placeholder: placeholder, class: 'form-control',
        onkeyup: '$(this.form).submitFormAsync();') +
        (content_tag :span, class: 'input-group-addon' do
          content_tag :i, '', class: 'fa fa-remove',
            onclick: '$(this).parent().prev()[0].value="";$($(this).parent().prev()[0].form).submitFormAsync();' do
          end
        end)
    end
  end
end
