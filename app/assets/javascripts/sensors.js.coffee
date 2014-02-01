# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->
  temp_data = []
  start_date = 0
  end_date = 0
  randomDate = (start, end) ->
    new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()))
  getRandomInt = (min, max) ->
    Math.floor Math.random() * (max - min + 1) + min
  fakeData = ->
    i = 0
    query = "insert into sensors (frequency, name, modulation_id,room_id, created_at, updated_at) values "
    while i < 10
      date = randomDate(new Date(2012, 0, 9), new Date())
      date2 = randomDate(new Date(2012, 0, 9), new Date()).getTime()
      randNum = getRandomInt(-5, 30)
      randNum2 = getRandomInt(15, 26)
      temp_data.push
        date: date.getTime()
        capteur1: randNum
        capteur3: getRandomInt(20, 24)

      temp_data.push
        date: date2
        capteur2: randNum2

      i++
    query = query.slice(0, -1)+";"
    console.log(query)
      
  init_date = ->
    start = moment().month(-3)
    end = moment()
    $("#reportrange span").html start.format("MMMM D, YYYY") + " - " + end.format("MMMM D, YYYY")
    start_date = start._d
    end_date = end._d
  
  $("li").click ->
    $("nav>ul>li").removeClass "active"
    $(this).addClass "active"

  $("#menu-switch").click ->
    if $("#foreground").css("left") is "0px"
      $("#foreground").css("left", "0px").removeClass "left-offset"
      $("#foreground").animate
        left: "-142px"
      , 400, ->
        $(this).removeAttr "style"

      $("#wrap").css("left", "150px").removeClass "main-offset"
      $("#wrap").animate
        left: "8px"
      , 400, ->
        $(this).removeAttr "style"

    else
      $("#foreground").animate
        left: "0px"
      , 400, ->
        $(this).addClass("left-offset").removeAttr "style"

      $("#wrap").animate
        left: "150px"
      , 400, ->
        $(this).addClass("main-offset").removeAttr "style"


  #fakeData()
  init_date()
  graph = Morris.Line(    
    # ID of the element in which to draw the chart.
    element: "temp_chart"
    # Chart data records -- each entry in this array corresponds to a point on
    # the chart.
    data: temp_data    
    # The name of the data record attribute that contains x-values.
    xkey: "date"    
    # A list of names of data record attributes that contain y-values.
    ykeys: [""]
    # Labels for the ykeys -- will be displayed when you hover over the chart.
    labels: ["Year"]
    gridTextFamily: "helvetica_neueultralight"
    hideHover: "auto"
    smooth: false
    resize: true
  )
  $("#reportrange").daterangepicker
    ranges:
      Yesterday: [moment().subtract("days", 1), moment().subtract("days", 1)]
      "Last 7 Days": [moment().subtract("days", 6), moment()]
      "This Month": [moment().startOf("month"), moment().endOf("month")]
      "Last Month": [moment().subtract("month", 1).startOf("month"), moment().subtract("month", 1).endOf("month")]

    startDate: moment().subtract("days", 29)
    endDate: moment()
  , (start, end) ->
    $("#reportrange span").html start.format("MMMM D, YYYY") + " - " + end.format("MMMM D, YYYY")
    start_date = start._d
    end_date = end._d
    graph.updateData graph.options.data, start_date, end_date

  $(".multiselect").multiselect onChange: (element, checked) ->
    if checked
      graph.addYkey element.val(), element.text(), start_date, end_date
    else
      graph.removeYkey element.val(), element.text(), start_date, end_date
