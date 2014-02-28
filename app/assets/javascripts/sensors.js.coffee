# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require d3
#= require moment
#= require rickshaw

jQuery(document).ready ($) ->
  palette = new Rickshaw.Color.Palette()
  $.get '/sensors/list'
    , (ajax_series) ->
      ajax_series.forEach (s) ->
        s.color = palette.color()

      ajaxGraph = new Rickshaw.Graph.Ajax.PointFrequency(
        element: $("#temp_chart")[0]
        width: $("#temp_chart").width()
        height: $("#temp_chart").height()
        renderer: "line"
        dataURL: "/sensors/"+Rickshaw.Graph.Ajax.genURL(ajax_series)+"/sensor_data"
        dataType: "json"
        is_init:false
        series: ajax_series
        leftElement: $("#leftFreq")[0]
        rightElement: $("#rightFreq")[0]
        selectorElement: $("#freqSelector")[0]
        selectedFrequency: 'month'

        # onData: (d) ->
        #   Rickshaw.Series.zeroFill d
        #   d

        onComplete: (transport) ->
          graph = transport.graph
          if !transport.args.is_init
            transport.args.is_init = true
            preview = new Rickshaw.Graph.RangeSlider.Preview(
              graph: graph
              width: $("#selectorContainer").width()-($("#leftFreq").width()+$("#rightFreq").width()+40)
              height: 80
              element: $("#preview")[0]
            )
            detail = new Rickshaw.Graph.HoverDetail(
              graph: graph
            )
            legend = new Rickshaw.Graph.Legend(
              graph: graph
              element: document.querySelector("#legend")
            )       
            shelving = new Rickshaw.Graph.Behavior.Series.Toggle(
              graph: graph
              legend: legend
              transport: transport
              callback : (url, value) ->
                $.post "/sensors/"+url+"/active_sensor", 
                  is_activated: value
            )
            highlighter = new Rickshaw.Graph.Behavior.Series.Highlight(
              graph: graph
              legend: legend
            )
            xAxis = new Rickshaw.Graph.Axis.Time(
              graph: graph
            )
            xAxis.render()
            yAxis = new Rickshaw.Graph.Axis.Y(
              graph: graph
              orientation: 'left'
              element: $("#yAxis")[0]
            )
            yAxis.render()

            previewXAxis = new Rickshaw.Graph.Axis.Time(
              graph: preview.previews[0]
              timeFixture: new Rickshaw.Fixtures.Time.Local()
            )
            previewXAxis.render();


          return
      )
    , 'json'