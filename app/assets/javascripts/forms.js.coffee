$.fn.clearForm = ->
  @each ->
    type = @type
    tag = @tagName.toLowerCase()
    if tag == 'form'
      $(':input', this).clearForm()
    if type == 'text' || type == 'password' || type == 'search' || tag == 'textarea'
      @value = ''
    else if type == 'checkbox' || type == 'radio'
      @checked = false
    else if tag == 'select'
      @selectedIndex = -1

$.fn.submitFormAsync = ->
  setTimeout (=> @submit()), 0

$.fn.submitFormRemote = ->
  @attr 'data-remote', 'true'
  @trigger 'submit.rails'
  @removeAttr 'data-remote'
  @removeData 'remote'

$.fn.initBootstrapCheckboxes = ->
  @find('input[type="checkbox"]').bootstrapSwitch();

$(document).on 'turbolinks:load', ->
  $("input[type='checkbox']").bootstrapSwitch();

  $('textarea.codemirror').each ->
    CodeMirror.fromTextArea @,
      mode: $(@).attr 'data-codemirror-mode'
      theme: 'base16-dark'
      lineNumbers: true
      matchBrackets: true
