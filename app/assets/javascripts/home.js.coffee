
jQuery(document).ready ($) ->
  if(@current_tmp == 9999)
    $('#currenttemp').text("Current home's temperature: Unknown").css("color","#FA0000")
  else if(@current_tmp < 17)
    $('#currenttemp').text("Current home's temperature: " + @current_temp + "&deg;C").css("color","#2C5DE5")
  else if(@current_tmp > 23)
    $('#currenttemp').text("Current home's temperature: " + @current_temp + "&deg;C").css("color","#EF6F00")
  else 
    $('#currenttemp').text("Current home's temperature: " + @current_temp + '&deg;C').css("color","#007B00")	
