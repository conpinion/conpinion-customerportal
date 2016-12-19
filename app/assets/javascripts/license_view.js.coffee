$(document).on 'turbolinks:load', ->
  return unless $('.licenses_view.new_action').length ||
      $('.licenses_view.create_action').length

  $('#license_product_id').change ->
    $(@form).submitFormRemote()
