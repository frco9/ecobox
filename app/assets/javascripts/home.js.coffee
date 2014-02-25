
jQuery(document).ready ($) ->
  if(@current_tmp == 9999)
    $('#currenttemp').text("Current home's temperature: Unknown").css("color","#FA0000")
