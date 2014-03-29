jQuery(document).ready(function($){

    function print_temp(element_div, min, max, avg, cur){

  var mycanvas= $('<canvas width="130px" height="250px" />');
  element_div.append(mycanvas);
  var context = mycanvas[0].getContext('2d');

  context.beginPath();
  var taille = 150;
  var largeur = 30;
  var decalage = 70;
  var debut = 65;
  // degradé:
  var gradient = context.createLinearGradient(0, debut, 0, debut + taille);
  gradient.addColorStop("1","blue");
  gradient.addColorStop("0.80","green");
  gradient.addColorStop("0.20","orange");
  gradient.addColorStop("0","red");
  context.fillStyle = gradient;
  // Barre:
  context.fillRect(decalage, debut, largeur, taille);
  
  // Affichage des données:
  context.save();
  context.beginPath();
  context.fillStyle= "blue";
  context.font = "12pt Calibri";
  context.textAlign="right";
  context.fillText("min: " + min, decalage-5, debut + taille - 2);

  context.save();
  context.beginPath();
  context.fillStyle= "red";
  context.font = "12pt Calibri";
  context.textAlign="right";
  context.fillText("max: " + max, decalage-5, debut + 12);

  context.save();
  context.beginPath();
  context.fillStyle= "orange";
  context.font = "12pt Calibri";
  context.textAlign="right";
  context.fillText("moy: " + avg, decalage-5, debut + taille/2);

  context.save();
  context.beginPath();
  var pos = (taille-12)*(cur-min)/(max-min);
  context.fillStyle= "#33cc00";
  context.font = "12pt Calibri";
  context.textAlign="left";
  context.fillText(cur,decalage+largeur+2, debut + taille - pos);
  
  context.save();
  context.beginPath();
  context.fillStyle= "#33cc00";
  context.font = "12pt Calibri";
  context.textAlign="left";
  context.fillText("act:", decalage + largeur +2, debut - 2);

  context.save();
  context.beginPath();
  context.fillStyle= "#303030";
  context.font = "12pt Calibri";
  context.textAlign="center";
  context.fillText("°C", decalage + largeur/2, debut - 2);
  
  context.stroke();
  return context;
  
    }

    
    $('input.temp').wrap('<div class="temp" />').each(function(index){
  var element_input = $(this);
  var element_div = element_input.parent();
  var taille = element_input.data('taille') ? element_input.data('taille') : 100 ;
  


    element_div.width(200)
      .height(250);
  
  
  element_input.width(taille)
      .css("font-size","22px")
      .css("top","0px")
      .css("left","0px")
      .css("color","#303030");


  var min = element_input.data('min');
  var max = element_input.data('max');
  var avg = element_input.data('avg');
  var cur = element_input.data('curin');
  var ext = element_input.data('curout');
  
  print_temp(element_div,min,max,avg,cur);
  
    });

  // Automatic page reload every 3min:
  // setInterval(function(){
  //   $.get('/', function(result){
  //     $("#content .row").html($(result).find("#content .row .sec_content"));
  //   }, 'html');
  //   $.getScript("assets/home_temp.js");
  //   $.getScript("assets/home_conso.js");
  //   $.getScript("assets/home_other_type.js");
  // },180000);

});
