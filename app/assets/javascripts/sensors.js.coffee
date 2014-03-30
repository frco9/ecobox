# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require d3
#= require moment
#= require rickshaw

jQuery(document).ready ($) ->
  palette = new Rickshaw.Color.Palette()
  scales = {} 
  
  # This function return a string with a unit corresponding to data type
  # It would be cleanner by doing it server side.
  getAxisUnit = (data_type_id) ->
    switch data_type_id
      when 1
        return "°C"
      when 2
        return "hPa"
      when 3
        return "%"
      when 4
        return "kWh"
    
  
  initYaxis = (graph) ->
    graph.series.active().forEach (serie) ->
      # Create one left yAxis for the first active serie
      if $("#temp_chart").index() == 1
        $("<div id=\"yAxis_"+serie.data_type_id+"\" class=\"col-xs-1\" style=\"width: 35px; height:410px; padding-left: 0; padding-right: 0;\"></div>").insertBefore("#temp_chart");
        yAxis = new Rickshaw.Graph.Axis.Y.Scaled
          graph: graph
          orientation: 'left'
          element: $("#yAxis_"+serie.data_type_id)[0]
          scale: scales[serie.data_type_id]
          label:
            text: getAxisUnit serie.data_type_id
            color: 'black'
            opacity: 0.5
            fontSize: '12px'
            offsetX: '1em'
            offsetY: '0em'
        yAxis.render()
      # Right yAxis for the others if not already created
      else if !$("#yAxis_"+serie.data_type_id).length
        $("<div id=\"yAxis_"+serie.data_type_id+"\" class=\"col-xs-1\" style=\"width: 35px; height:410px; padding-left: 0; padding-right: 0;\"></div>").insertBefore("#graphContainer #rightMarginFix");
        yAxis = new Rickshaw.Graph.Axis.Y.Scaled
          graph: graph
          grid: false
          orientation: 'right'
          element: $("#yAxis_"+serie.data_type_id)[0]
          scale: scales[serie.data_type_id]
          label:
            text: getAxisUnit serie.data_type_id
            color: 'black'
            opacity: 0.5
            fontSize: '12px'
            offsetX: '1em'
            offsetY: '0em'
        yAxis.render()
    # Adapt graph width to new yAxis
    graph.configure
      width: $("#graphContainer").width()-($("#graphContainer .col-xs-1").width()*$("#graphContainer .col-xs-1").length  + parseInt($("#graphContainer .col-xs-2").css("margin-left"))*$("#graphContainer .col-xs-2").length) # Container width - with of each Y axis (Yaxis width + margins)*number_of_yAxis
    graph.render()
    return

  updateYAxis = (url, is_activated, graph) ->
    # Serie enabled
    if is_activated
      url.split(",").forEach (item) ->
        data_type = item.split("-")[1]
        # Check if yAxis already displayed
        if !$("#yAxis_"+data_type).length
          $("<div id=\"yAxis_"+data_type+"\" class=\"col-xs-1\" style=\"width: 35px; height:410px; padding-left: 0; padding-right: 0;\"></div>").insertBefore("#graphContainer #rightMarginFix");
          yAxis = new Rickshaw.Graph.Axis.Y.Scaled
            graph: graph
            grid: false
            orientation: 'right'
            element: $("#yAxis_"+data_type)[0]
            scale: scales[data_type]
            label:
              text: getAxisUnit data_type
              color: 'black'
              opacity: 0.5
              fontSize: '12px'
              offsetX: '1em'
              offsetY: '0em'
          yAxis.render()
    else
      url.split(",").forEach (item) ->
        data_type = item.split("-")[1]
        id = item.split("-")[0]
        lastActivated = true
        # Check if there are other series activated with the same type
        graph.series.active().forEach (serie) ->
          if parseInt(data_type) == serie.data_type_id
            lastActivated = false
        # If it the last, can be removed
        if lastActivated
          $("#yAxis_"+data_type).remove()
          # If left axis was removed, the right one is moved to the left
          if $("#temp_chart").index() == 1
            # Remove the grid
            $(".y_grid").remove()
            # Select the first right yAxis get its id 
            rightAxisId = parseInt($("#temp_chart").next().attr("id").split("_")[1])
            # Empty it and moves it to the left
            $("#temp_chart").next().empty().insertBefore($("#temp_chart"))
            # Left yAxis new instance
            yAxis = new Rickshaw.Graph.Axis.Y.Scaled
              graph: graph
              orientation: 'left'
              element: $("#yAxis_"+rightAxisId)[0]
              scale: scales[rightAxisId]
              label:
                text: getAxisUnit data_type
                color: 'black'
                opacity: 0.5
                fontSize: '12px'
                offsetX: '1em'
                offsetY: '0em'
            yAxis.render()
    
    # Adapt graph width to new yAxis
    graph.configure
      width: $("#graphContainer").width()-($("#graphContainer .col-xs-1").width()*$("#graphContainer .col-xs-1").length  + parseInt($("#graphContainer .col-xs-2").css("margin-left"))*$("#graphContainer .col-xs-2").length) # Container width - with of each Y axis (Yaxis width + margins)*number_of_yAxis
    graph.render()
    return
  
  $.get '/sensors/list'
    , (ajax) ->

      ajax.series.forEach (s) ->
        # Fill scales hash array with min and max value of each series type.
        # Key doesn't exist yet ?
        if scales[s.data_type_id] == undefined
          scales[s.data_type_id] = {"max": s.maxValue, "min": s.minValue}
        else
          scales[s.data_type_id]["max"] = Math.max(scales[s.data_type_id]["max"], s.maxValue)
          scales[s.data_type_id]["min"] = Math.min(scales[s.data_type_id]["min"], s.minValue)
      
      for key of scales
        scales[key] = d3.scale.linear().domain([scales[key]["min"], scales[key]["max"]]).nice()
      
      ajax.series.forEach (s) ->
        # Set color to the serie
        s.color = palette.color()
        # Set correct scale
        s.scale = scales[s.data_type_id]

      # Graph initialization
      ajaxGraph = new Rickshaw.Graph.Ajax.PointFrequency(
        element: $("#temp_chart")[0]
        width: $("#graphContainer").width()-($("#graphContainer .col-xs-1").width()*$("#graphContainer .col-xs-1").length  + parseInt($("#graphContainer .col-xs-2").css("margin-left"))*$("#graphContainer .col-xs-2").length) # Container width - with of each Y axis (Yaxis width + margins)*number_of_yAxis
        height: $("#temp_chart").height()
        renderer: "multi"
        interpolation: "linear"
        dataURL: "/sensors/"+Rickshaw.Graph.Ajax.genURL(ajax.series)+"/sensor_data"
        dataType: "json"
        is_init:false
        series: ajax.series
        leftElement: $("#leftFreq")[0]
        rightElement: $("#rightFreq")[0]
        selectorElement: $("#freqSelector")[0]
        selectedFrequency: 'week'
        minDate: ajax.minDate
        maxDate: ajax.maxDate

        # When needed, fill missing data with an avarage of next and previous value. 
        onData: (d) ->
          Rickshaw.Graph.Ajax.PointFrequency.fillAvg(d,0)
          d

        # Data specified un dataURL is now in series array
        # Pluggins can now be initialize
        onComplete: (transport) ->
          graph = transport.graph
          if !transport.args.is_init
            transport.args.is_init = true
            preview = new Rickshaw.Graph.RangeSlider.Preview(
              graph: graph
              width: $("#selectorContainer").width()-($("#leftFreq").width()+$("#rightFreq").width()+45)
              height: 80
              element: $("#preview")[0]
            )
            detail = new Rickshaw.Graph.HoverDetail(
              graph: graph
            )
            legend = new Rickshaw.Graph.Legend.Typed(
              graph: graph
              introText: "Selectionner un capteur"
              element: document.querySelector("#legend")
            )       
            shelving = new Rickshaw.Graph.Behavior.Series.Toggle(
              graph: graph
              legend: legend
              transport: transport
              callback : (url, value) ->
                $.post "/sensors/"+url+"/active_sensor", 
                  is_activated: value
                  updateYAxis(url, value, graph)
            )
            highlighter = new Rickshaw.Graph.Behavior.Series.Highlight(
              graph: graph
              legend: legend
            )
            xAxis = new Rickshaw.Graph.Axis.Time(
              graph: graph
            )
            xAxis.render()
            # Automatically create yAxis for all series activated.
            initYaxis graph

            # xAxis for graph slider preview
            previewXAxis = new Rickshaw.Graph.Axis.Time(
              graph: preview.previews[0]
              timeFixture: new Rickshaw.Fixtures.Time.Local()
            )
            previewXAxis.render()
          return
      )
    , 'json'
