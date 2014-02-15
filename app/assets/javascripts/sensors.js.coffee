# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require raphael
#= require morris
#= require moment
#= require daterangepicker
#= require bootstrap-multiselect

jQuery(document).ready ($) ->
  window.sensors_data = []
  start_date = 0
  start_date_max = 0
  end_date = 0
  end_date_max = 0
  init_data_length = 30

  initData = ->
    i = 0
    while i < init_data_length
      date = moment().day(-(30-i)).valueOf();
      sensors_data.push
        date: date
        init: 0
      i++
    return
  initDate = ->
    start = moment().month(-0)
    end = moment()
    $("#reportrange span").html start.format("MMMM D, YYYY") + " - " + end.format("MMMM D, YYYY")
    start_date = start.toDate()
    end_date = end.toDate()
    start_date_max = moment().month(-2).toDate()
    end_date_max = end.toDate()
    return

  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')

  getData = (url, sensor_id, f, g) ->
    if !url?
      url = "sensors/"
      $('.multiselect option:checked').map ->
          url += this.value+","
        .get
      url = url.slice(0,-1)+"/sensor_data"
    if !sensor_id?
      $('.multiselect option:checked').map ->
          sensor_id = this.value
        .get
      if !sensor_id?
        return

    if end_date_max < end_date and start_date_max > start_date
      end_date_max = end_date
      start_date_max = start_date
    else if end_date_max >= end_date and start_date_max > start_date
      start_date_max = start_date
    else if end_date_max < end_date and start_date_max <= start_date
      end_date_max = end_date
    else
      #We check if we have data for required sensor
      key_exist = false
      $.map sensors_data
        , (elementOfArray, indexInArray) =>
          if sensor_id? and elementOfArray.hasOwnProperty(sensor_id)
            key_exist = true
      if key_exist and typeof f is 'function'  
        f()
        return

    $.ajax
      type: "POST"
      url: url #"sensors/"+element.val()+"/sensor_data"
      data: 
        start_date: start_date_max
        end_date: end_date_max
      dataType: "json"
      success: (data) ->
        if typeof g is 'function'
          g(data)    
        if typeof f is 'function'
          f()
    return
  $("li").click ->
    $("nav>ul>li").removeClass "active"
    $(this).addClass "active"
    return

  $("#menu-switch").click ->
    if $("#foreground").css("left") is "0px"
      $("#foreground").css("left", "0px").removeClass "left-offset"
      $("#foreground").animate
        left: "-142px"
      , 400, ->
        $(this).removeAttr "style"
        return

      $("#wrap").css("left", "150px").removeClass "main-offset"
      $("#wrap").animate
        left: "8px"
      , 400, ->
        $(this).removeAttr "style"
        return

    else
      $("#foreground").animate
        left: "0px"
      , 400, ->
        $(this).addClass("left-offset").removeAttr "style"
        return

      $("#wrap").animate
        left: "150px"
      , 400, ->
        $(this).addClass("main-offset").removeAttr "style"
        return

    return

  initData()
  initDate()
  window.graph = Morris.Line(
    # ID of the element in which to draw the chart.
    element: "temp_chart"
    # Chart data records -- each entry in this array corresponds to a point on
    # the chart.
    data: sensors_data
    # The name of the data record attribute that contains x-values.
    xkey: "date"
    # A list of names of data record attributes that contain y-values.
    ykeys: [""]
    # Labels for the ykeys -- will be displayed when you hover over the
    # chart.
    labels: ["Init"]
    gridTextFamily: "helvetica_neueultralight"
    hideHover: "auto"
    smooth: false
    resize: true
    minVal: true
    maxVal: true
    sortData: false
  )
  $("#reportrange").daterangepicker
    ranges:
      Yesterday: [
        moment().subtract("days", 1)
        moment().subtract("days", 1)
      ]
      "Last 7 Days": [
        moment().subtract("days", 6)
        moment()
      ]
      "This Month": [
        moment().startOf("month")
        moment().endOf("month")
      ]
      "Last Month": [
        moment().subtract("month", 1).startOf("month")
        moment().subtract("month", 1).endOf("month")
      ]

    startDate: moment().subtract("days", 29)
    endDate: moment()
  , (start, end) ->
    $("#reportrange span").html start.format("MMMM D, YYYY") + " - " + end.format("MMMM D, YYYY")
    start_date = start.toDate()
    end_date = end.toDate()
    getData null
      , null
      , ->
        graph.updateData graph.options.data, start_date, end_date
      , (data) ->
        window.sensors_data.length = 0
        $.each data.selected_data, ->
          $.merge(sensors_data, this) 
    return

  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')

  $(".multiselect").multiselect onChange: (element, checked) ->
    if checked
      getData "sensors/"+element.val()+"/sensor_data"
        , element.val()
        , ->
          graph.addYkey element.val(), element.text(), start_date, end_date
        , (data) ->
          $.each data.selected_data, ->
            $.merge(sensors_data, this) 

    else
      graph.removeYkey element.val(), element.text(), start_date, end_date
    return

  return    #Le changement de data ne se fait pas necessairement hors getData mais plutot dedans en fonction de la periode choisie.
