jQuery(document).ready(function($){

    function print_gauge(element_div , taille , taille_jauge, debut_jauge, color , ombre, contexte, degrade){
	
	if(contexte===true){
	    
	    var circle = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(circle);
	    // on configure notre plan de travail : 2 dimentions
	    var ctx = circle[0].getContext('2d');
	    
	}else{
	    ctx = contexte;
	}
	
	// beginning of the print
	ctx.beginPath();
	if(degrade){
	    //ctx.translate(taille,taille)
	    //var gradient = ctx.createRadialGradient(taille*1.25 - taille/100*85*Math.cos(debut_jauge + Math.PI), taille*1.25 - taille/100*85*Math.sin(debut_jauge + Math.PI),debut_jauge + Math.PI, taille*1.25 - taille/100*85*Math.cos(debut_jauge + taille_jauge + Math.PI), taille*1.25 - taille/100*85*Math.sin(debut_jauge + taille_jauge + Math.PI), debut_jauge + taille_jauge + Math.PI);
	    var gradient = ctx.createLinearGradient(taille*1.25 - taille/100*80*Math.cos(debut_jauge+ (3/4)*Math.PI), taille*1.25 - taille/100*80*Math.sin(debut_jauge+ (3/4)*Math.PI), taille*1.25 - taille/100*80*Math.cos(debut_jauge+taille_jauge+ (5/4)*Math.PI), taille*1.25 - taille/100*80*Math.sin(debut_jauge+taille_jauge + (5/4)*Math.PI));
	    //gradient.addColorStop("0","#303030");
	    gradient.addColorStop("0","blue");
	    gradient.addColorStop("0.13","green");
	    gradient.addColorStop("0.80","orange");
	    gradient.addColorStop("1","red");
	    //gradient.addColorStop("1","#303030");
	    ctx.strokeStyle = gradient;
	}
	else{
	    ctx.strokeStyle = color;
	}
	// printing of the empty circle
	ctx.arc(taille*1.25,taille*1.25,(taille/100*85),  debut_jauge, taille_jauge + debut_jauge); 
	// width of edge
	ctx.lineWidth = (taille/100*20);
	
	
	if(ombre){
	    // position of the shadow
	    ctx.shadowOffsetX = (taille/100*1.5);
	    // width of the shadow
	    ctx.shadowBlur = (taille/100*8);
	    // color of shadow
	    ctx.shadowColor='rgba(0,0,0,0.5)';
	}
	//fin du dessin
	ctx.stroke();
	
	return ctx;
    }
    
    function print_avg(element_div, taille, taille_jauge, debut_jauge, avg_angle, color, contexte){
	
	if(contexte===true){
	    
	    var circle = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(circle);
	    // on configure notre plan de travail : 2 dimentions
	    var ctx = circle[0].getContext('2d');
	    
	}else{
	    ctx = contexte;
	}
	
	ctx.beginPath();
	ctx.strokeStyle= color;
	ctx.lineWidth=4;	    
	// avg line:
	// (taille,taille) = center of circle
	// taille/100*85 = radius of the circle
	// taille/100*20 = width of the gauge
	// taille/100*8 = width of the shadow
	// taille/100*85 - taille/100*20 + taille/100*8 = taille/100*73 = width of the intern circle
	ctx.moveTo(taille*1.25 - taille/100*73*Math.cos(avg_angle), taille*1.25 - taille/100*73*Math.sin(avg_angle));
	// taille/100*85 + taille/100*20 - taille/100*8 = taille/100*97 = extern edge of the circle
	ctx.lineTo(taille*1.25 - taille/100*97*Math.cos(avg_angle), taille*1.25 - taille/100*97*Math.sin(avg_angle));

	//fin du dessin
	ctx.stroke();
	
	return ctx;
    }
    
    
    function print_cur(element_div, taille, taille_jauge, debut_jauge, cur_angle, color, contexte){
	
	if(contexte===true){
	    
	    var circle = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(circle);
	    // on configure notre plan de travail : 2 dimentions
	    var ctx = circle[0].getContext('2d');
	    
	}else{
	    ctx = contexte;
	}
	
	ctx.beginPath();
	ctx.strokeStyle= "#33cc00";
	ctx.globalAlpha=0.65;
	ctx.lineWidth=3;
	// (taille,taille) = center of circle
	// taille/100*85 = radius of the circle
	// taille/100*20 = width of the gauge
	// taille/100*8 = width of the shadow
	// taille/100*85 - taille/100*20 + taille/100*8 = taille/100*73 = width of the intern circle
	ctx.moveTo(taille*1.25 - taille/100*75*Math.cos(cur_angle), taille*1.25 - taille/100*75*Math.sin(cur_angle));
	ctx.lineTo(taille*1.25 - taille/100*50*Math.cos(cur_angle+(Math.PI/16)), taille*1.25 - taille/100*50*Math.sin(cur_angle+(Math.PI/16)));
	ctx.moveTo(taille*1.25 - taille/100*75*Math.cos(cur_angle), taille*1.25 - taille/100*75*Math.sin(cur_angle));
	ctx.lineTo(taille*1.25 - taille/100*50*Math.cos(cur_angle-(Math.PI/16)), taille*1.25 - taille/100*50*Math.sin(cur_angle-(Math.PI/16)));
	ctx.moveTo(taille*1.25 - taille/100*50*Math.cos(cur_angle-(Math.PI/16)), taille*1.25 - taille/100*50*Math.sin(cur_angle-(Math.PI/16)));


	//fin du dessin
	ctx.stroke();
	
	return ctx;
    }

    
    function print_nb(element_div, taille, taille_jauge, debut_jauge, born_min, born_max, min, max, avg, cur, avg_angle, cur_angle, contexte){
	
	if(contexte===true){
	    
	    var circle = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(circle);
	    // on configure notre plan de travail : 2 dimentions
	    var ctx = circle[0].getContext('2d');
	    
	}else{
	    ctx = contexte;
	}

	// Print of graduation:
	for (var i=0; i<12; i++){
	    ctx.beginPath();
	    ctx.fillStyle= "#303030";
	    ctx.font = "10pt Arial";
	    ctx.textAlign="center"; 
	    var grad = i*(born_max-born_min)/12 + born_min;
	    ctx.fillText(grad,taille*1.25 - taille/100*105*Math.cos(i*Math.PI/6+debut_jauge+taille_jauge), taille*1.25 - taille/100*105*Math.sin(i*Math.PI/6+debut_jauge+taille_jauge));
	}
	
	ctx.save();
	// Print of min number:
	ctx.beginPath();
	ctx.fillStyle= "blue";
	ctx.font = "10pt Arial";
	ctx.textAlign="center"; 
	ctx.fillText(min,taille*1.25 - taille/100*60*Math.cos(debut_jauge+Math.PI), taille*1.25 - taille/100*60*Math.sin(debut_jauge+Math.PI));
ctx.save();
	
	// Print of max number:
	ctx.beginPath();
	ctx.fillStyle= "red";
	ctx.font = "10pt Arial";
	ctx.textAlign="center"; 
	ctx.fillText(max,taille*1.25 - taille/100*60*Math.cos(debut_jauge+taille_jauge+Math.PI), taille*1.25 - taille/100*60*Math.sin(debut_jauge+taille_jauge+Math.PI));
	
	ctx.save();
	// Print of avg number:
	ctx.beginPath();
	ctx.fillStyle= "orange";
	ctx.font = "10pt Arial";
	ctx.textAlign="center"; 
	ctx.fillText(avg,taille*1.25 - taille/100*60*Math.cos(avg_angle), taille*1.25 - taille/100*60*Math.sin(avg_angle));

	ctx.stroke();
    }
    
    function print_anneau(num){
	var canvas = document.getElementById("legende");
	var context = canvas.getContext("2d");
	
	if(num == 1){
	    
	    context.beginPath();
	    context.strokeStyle = "orange";
	    context.lineWidth=4;	    
	    context.moveTo(50,70);
	    context.lineTo(80,70);
	}
	else{
	    context.beginPath();
	    context.strokeStyle = "#33cc00";
	    context.lineWidth=3;	    
	    context.moveTo(82,40);
	    context.lineTo(110,50);
	    context.moveTo(82,40);
	    context.lineTo(110,30);
	}
	
	context.stroke();
	
	return context;

    }
    function print_legende(){
	var canvas = document.getElementById("legende");
	var context = canvas.getContext("2d");
	
	context.beginPath();
	var gradient = context.createLinearGradient(0, 0, 0, 100);
	gradient.addColorStop("1","blue");
	gradient.addColorStop("0.70","green");
	gradient.addColorStop("0.30","orange");
	gradient.addColorStop("0","red");
	context.fillStyle = gradient;
	context.fillRect(50, 0, 30, 100);
	
	context.save();
	// Legend of min:
	context.beginPath();
	context.fillStyle= "blue";
	context.font = "12pt Calibri";
	context.textAlign="rigth"; 
	context.fillText("Donnée minimale de la journée dans votre maison",85, 99);
	

	context.save();
	// Legend of max
	context.beginPath();
	context.fillStyle= "red";
	context.font = "12pt Calibri";
	context.textAlign="rigth"; 
	context.fillText("Donnée maximale de la journée dans votre maison",85, 12)

	context.save();
	// Legend of avg
	context.beginPath();
	context.fillStyle= "orange";
	context.font = "12pt Calibri";
	context.textAlign="rigth"; 
	context.fillText("Donnée moyenne de la journée dans votre maison",85, 75)

	context.save();
	// Legend of current
	context.beginPath();
	context.fillStyle= "#33cc00";
	context.font = "12pt Calibri";
	context.textAlign="rigth"; 
	context.fillText("Donnée actuelle de la journée dans votre maison",120, 45)


	context.stroke();
	return context;
	
    }

	
    
    // on entour le champs texte avec une Div qui contiendra notre jauge
    $('input.compteur').wrap('<div class="compteur" />').each(function(){
	

	// initialisation des variables
	var element_input = $(this); // le champs texte
	var element_div = element_input.parent(); // la div
	
	// on récupère le type des données de la jauge
	var type = element_input.data('type');
	
	// on récupère la valeur minimum de la jauge
	var min = element_input.data('min');
	// le maximum
	var max = element_input.data('max');
	// la moyenne
	var avg = element_input.data('avg');
	// et l'actuel
	var cur = element_input.data('cur');
	

	switch(type){
	case 'Temperature':
            var born_min = 0;
	    var born_max = 60;
	    break;
	case 'Pression':
	    var born_min = 0;
	    var born_max = 60;
	    break;
	case 'Hygrometrie':
	    var born_min = 0;
	    var born_max = 60;
	    break;
	case 'Consommation':
	    var born_min = 0;
	    var born_max = 60;
	    break;
	}
	// On modifie la born min et la born max selon les valeurs min et max
	
	if (min < born_min){
	    born_min = min;
	}
        
	if (max > born_max){
	    born_max = max;
	}
	
	//la couleur de la jauge
	var color = element_input.data('color') ? element_input.data('color') : "#33cc00"/*= vert*/ ;
	// sa taille
	var taille = element_input.data('taille') ? element_input.data('taille') : 100 ;
	
	// on met en forme la div et le champs texte
	element_div.width(taille*2.5)
	    .height(taille*2.5);
	element_input.width(taille)
	    .css("font-size",(taille/100*40)+"px")
	    .css("top",(taille/100*100)+"px")
	    .css("left",(taille/100*75)+"px")
	    .css("color","#33cc00");
	
	
	var taille_jauge = (max - min)/(born_max - born_min)*2*Math.PI;
	var debut_jauge = (Math.PI)*((1/2) + 2*(min - born_min)/(born_max - born_min));
	var avg_angle = (avg/(born_max - born_min))*2*Math.PI + debut_jauge + taille_jauge;
	var cur_angle = (cur/(born_max - born_min))*2*Math.PI + debut_jauge + taille_jauge;
	
	//on dessine la jauge circulaire à l'aide du canevas
	print_gauge(element_div , taille , 2*Math.PI - taille_jauge, debut_jauge + taille_jauge, "#303030" , true , true,false);
	//on dessine le niveau de la jauge circulaire
	print_gauge(element_div , taille , taille_jauge, debut_jauge, color ,false , true, true);
	//on dessine la moyenne sur la jauge
	print_avg(element_div , taille ,taille_jauge, debut_jauge, avg_angle, 'orange' , true);
	print_nb(element_div, taille, taille_jauge, debut_jauge, born_min, born_max, min, max, avg, cur, avg_angle, cur_angle, true);
	
	var contexte = print_cur(element_div , taille ,taille_jauge, debut_jauge, cur_angle, 'red' , true);
	
    });
    

    print_legende();
    print_anneau(1);   
    print_anneau(0);    
    //$('input.legende').wrap('<div class="legende" />').each(function(){
   
});

