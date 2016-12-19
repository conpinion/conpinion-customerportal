data =
  labels: [
    <% @labels.each do |l| %>'<%= l %>', <% end %>
  ]
  series: [
    <% @data.each do |d| %>
    {name: '<%= d[:name] %>', data: <%= d[:data].to_json %>}
    <% end %>
  ]

options =
  width: '100%'
  height: '70vh'
  showPoint: false
  showArea: true
  fullWidth: true
  axisX:
    labelInterpolationFnc: (value, index) ->
      if index % <%= @labels.length / 10 %> == 0 then value else null
  axisY:
    labelInterpolationFnc: (value, index) ->
      if index % 2 == 0 then value else null
  lineSmooth: Chartist.Interpolation.cardinal({
    fillHoles: true,
  })
  plugins: [
    Chartist.plugins.zoom()
    Chartist.plugins.legend()
  ]
  
chart = new Chartist.Line '#chart-<%= @distributor.id %>-<%= @product&.id %> .ct-chart', data, options

chart.on 'draw', (data) ->
  if data.type == 'line' || data.type == 'area'
    data.element.animate
      d:
        begin: 100 * data.index,
        dur: 1000,
        from: data.path.clone().scale(1, 0).translate(0, data.chartRect.height()).stringify(),
        to: data.path.clone().stringify(),
        easing: Chartist.Svg.Easing.easeOutQuint

$('#chart-<%= @distributor.id %>-<%= @product&.id %> .fa-spinner').hide()
