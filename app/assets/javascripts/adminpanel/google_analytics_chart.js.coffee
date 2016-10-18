$(document).on 'turbolinks:load', ->
  if $('#google-stats').length
    margin =
      top: 20
      right: 20
      bottom: 20
      left: 30

    width = $('.widget-body').width() - margin.left - margin.right
    height = 450 - margin.top - margin.bottom

    data = $('.widget-body').data 'visits'

    x = d3.time.scale()
      .domain [new Date(data[0].date), new Date(data[data.length - 1].date) ]
      .range [0, width]

    y = d3.scale.linear()
      .domain(d3.extent(data, (d) -> +d.visits))
      .range([height, 0])

    xAxis = d3.svg.axis()
      .scale x
      .orient "bottom"

    yAxis = d3.svg.axis()
      .scale y
      .orient "left"

    line = d3.svg.line()
      .x (d) -> x new Date d.date
      .y (d) -> y d.visits

    chart = d3.select "#chart"
      .attr "width", width + margin.left + margin.right
      .attr "height", height + margin.top + margin.bottom
      .append "g"
        .attr "transform", "translate(#{margin.left}, #{margin.top})"


    chart.append "g"
      .attr "class", "x axis"
      .attr "transform", "translate(0, #{height})"
      .call xAxis

    chart.append "g"
      .attr "class", "y axis"
      .call yAxis
    .append "text"
      .attr "transform", "rotate(-90)"
      .attr "y", 6
      .attr "dy", ".71em"
      .style "text-anchor", "end"
      .text "Visitas"

    chart.append "path"
      .datum data
      .attr "class", "line"
      .attr "d", line
