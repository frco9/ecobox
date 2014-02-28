###
jQuery(document).ready ($) ->
   if($(<%@unavailable_sensors>)
      message = "<section><article><div class=\"alert alert-warning\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button><span class=\"glyphicon glyphicon-warning-sign form-control-feedback\"></span><strong>Warning! Certains capteur ne sont inactifs: </strong><ul><% @unavailable_sensors.each do |sensor| %><li><td><%= sensor.room.name %>: </td><td> <%= sensor.name %> </td></li><% end %></ul>Pensez à vérifier les piles des capteurs concernés par cette alerte</div></article>";
      $('#Warning').text("Salut");
###