$(document).on 'turbolinks:load', ->
  return unless $('.dashboards_view.index_action')

  $('.chart-panel').each ->
    $(@).find('a').click =>
      $(@).find('.ct-chart').empty()
      $(@).find('.fa-spinner').show()
  $('.chart-panel .fa-spinner').hide()
  $('.chart-panel a').each -> @.click()
