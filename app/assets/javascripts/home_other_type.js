jQuery(document).ready(function($){

    function print_gauge(element_div , taille , taille_jauge, debut_jauge, type , ombre, contexte, degrade){
	
	if(contexte==true){
	    var mycanvas = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(mycanvas);
	    var ctx = mycanvas[0].getContext('2d');
	}else{
	    ctx = contexte;
	}
	
	ctx.beginPath();
	// Translate to the center of the circle
	ctx.translate(taille*1.25,taille*1.25);
	if(degrade){
	    // Create a gradient:
	    switch(type){
	    case 'Hygrometrie':
		var portion = taille_jauge/3;
		var delta = taille_jauge/100;
		var gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge - Math.PI/2), - taille/100*80*Math.sin(debut_jauge - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + portion + delta - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + portion + delta - Math.PI/2));
		// Choose of the colors for the gradient
		gradient.addColorStop("0","#87A5D8");
		gradient.addColorStop("1","#1050BD");
		ctx.arc(0,0,(taille/100*85),  debut_jauge + Math.PI/2, debut_jauge + portion + delta + Math.PI/2,false); 
		ctx.lineWidth = (taille/100*20);
		ctx.strokeStyle = gradient;
		ctx.stroke();
		ctx.save();
		
		ctx.beginPath();
		gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge + portion - Math.PI/2), - taille/100*80*Math.sin(debut_jauge + portion - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + 2*portion + delta - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + 2*portion + delta - Math.PI/2));
		gradient.addColorStop("0","#1050BD");
		gradient.addColorStop("1","#11157F");
		ctx.arc(0,0,(taille/100*85),  debut_jauge + portion + Math.PI/2, debut_jauge + 2*portion + delta + Math.PI/2,false); 
		ctx.lineWidth = (taille/100*20);
		ctx.strokeStyle = gradient;
		ctx.stroke();
		ctx.save();

		ctx.beginPath();
		gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge + 2*portion - Math.PI/2), - taille/100*80*Math.sin(debut_jauge + 2*portion - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + taille_jauge - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + taille_jauge - Math.PI/2));
		gradient.addColorStop("0","#11157F");
		gradient.addColorStop("1","#010116");
		ctx.arc(0,0,(taille/100*85),  debut_jauge + 2*portion + Math.PI/2, debut_jauge + taille_jauge + Math.PI/2,false); 
		ctx.lineWidth = (taille/100*20);
		ctx.strokeStyle = gradient;
		ctx.save();
		break;
	    default:
		var portion = taille_jauge/3;
		var delta = taille_jauge/100;
		var gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge - Math.PI/2), - taille/100*80*Math.sin(debut_jauge - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + portion + delta - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + portion + delta - Math.PI/2));
		gradient.addColorStop("0","blue");
		gradient.addColorStop("1","green");
		ctx.arc(0,0,(taille/100*85),  debut_jauge + Math.PI/2, debut_jauge + portion + delta + Math.PI/2,false); 
		ctx.lineWidth = (taille/100*20);
		ctx.strokeStyle = gradient;
		ctx.stroke();
		ctx.save();

		ctx.beginPath();
		gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge + portion - Math.PI/2), - taille/100*80*Math.sin(debut_jauge + portion - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + 2*portion + delta - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + 2*portion + delta - Math.PI/2));
		gradient.addColorStop("0","green");
		gradient.addColorStop("1","orange");
		ctx.arc(0,0,(taille/100*85),  debut_jauge + portion + Math.PI/2, debut_jauge + 2*portion + delta + Math.PI/2,false); 
		ctx.lineWidth = (taille/100*20);
		ctx.strokeStyle = gradient;
		ctx.stroke();
		ctx.save();

		ctx.beginPath();
		gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge + 2*portion - Math.PI/2), - taille/100*80*Math.sin(debut_jauge + 2*portion - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + taille_jauge - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + taille_jauge + delta - Math.PI/2));
		gradient.addColorStop("0","orange");
		gradient.addColorStop("1","red");
		ctx.arc(0,0,(taille/100*85),  debut_jauge + 2*portion + Math.PI/2, debut_jauge + taille_jauge + Math.PI/2,false); 
		ctx.lineWidth = (taille/100*20);
		ctx.strokeStyle = gradient;
		ctx.save();
		break;
	    }
	}
	else{
	    ctx.strokeStyle = "#303030"; /*grey of ecobox*/
	    ctx.arc(0,0,(taille/100*85),  debut_jauge + Math.PI/2, taille_jauge + debut_jauge + Math.PI/2,false); 
	    ctx.lineWidth = (taille/100*20);
	}
	if(ombre){
	    ctx.shadowOffsetX = (taille/100*1.5);
	    ctx.shadowBlur = (taille/100*8);
	    ctx.shadowColor='rgba(0,0,0,0.5)';
	}
	ctx.stroke();
	return ctx;
    }
    
    function print_avg(element_div, taille, taille_jauge, debut_jauge, avg_angle, color, contexte){
	
	if(contexte==true){
	    var mycanvas = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(mycanvas);
	    var ctx = mycanvas[0].getContext('2d');
	}else{
	    ctx = contexte;
	}
	ctx.translate(taille*1.25,taille*1.25);

	ctx.beginPath();
	ctx.strokeStyle= color;
	ctx.lineWidth=4;	    
	ctx.moveTo(- taille/100*73*Math.cos(avg_angle - Math.PI/2),- taille/100*73*Math.sin(avg_angle - Math.PI/2));
	ctx.lineTo(- taille/100*97*Math.cos(avg_angle - Math.PI/2),- taille/100*97*Math.sin(avg_angle - Math.PI/2));
	ctx.stroke();
	return ctx;
    }
    
    
    function print_curin(element_div, taille, taille_jauge, debut_jauge, cur_angle, color, contexte){
	if(contexte==true){
	    var mycanvas = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(mycanvas);
	    var ctx = mycanvas[0].getContext('2d');
	}else{
	    ctx = contexte;
	}
	ctx.beginPath();
	ctx.translate(taille*1.25,taille*1.25);
	ctx.strokeStyle= color;
	ctx.globalAlpha=0.65;
	ctx.lineWidth=3;
	ctx.moveTo(- taille/100*75*Math.cos(cur_angle - Math.PI/2),- taille/100*75*Math.sin(cur_angle - Math.PI/2));
	ctx.lineTo(- taille/100*65*Math.cos(cur_angle+(Math.PI/32) - Math.PI/2),- taille/100*65*Math.sin(cur_angle+(Math.PI/32) - Math.PI/2));
	ctx.moveTo(- taille/100*75*Math.cos(cur_angle - Math.PI/2),- taille/100*75*Math.sin(cur_angle - Math.PI/2));
	ctx.lineTo(- taille/100*65*Math.cos(cur_angle-(Math.PI/32) - Math.PI/2),- taille/100*65*Math.sin(cur_angle-(Math.PI/32) - Math.PI/2));
	ctx.stroke();
	return ctx;
    }


    
    function print_curext(element_div, taille, taille_jauge, debut_jauge, ext, ext_angle, color, contexte){
	
	if(contexte==true){
	    var mycanvas = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(mycanvas);
	    var ctx = mycanvas[0].getContext('2d');
	}else{
	    ctx = contexte;
	}
	ctx.beginPath();
	ctx.translate(taille*1.25,taille*1.25);
	ctx.strokeStyle= color;
	ctx.globalAlpha=0.60;
	ctx.lineWidth=3;
	ctx.moveTo(- taille/100*95*Math.cos(ext_angle - Math.PI/2),- taille/100*95*Math.sin(ext_angle - Math.PI/2));
	ctx.lineTo(- taille/100*105*Math.cos(ext_angle+(Math.PI/64) - Math.PI/2),- taille/100*105*Math.sin(ext_angle+(Math.PI/64) - Math.PI/2));
	ctx.moveTo(- taille/100*95*Math.cos(ext_angle - Math.PI/2),- taille/100*95*Math.sin(ext_angle - Math.PI/2));
	ctx.lineTo(- taille/100*105*Math.cos(ext_angle-(Math.PI/64) - Math.PI/2),- taille/100*105*Math.sin(ext_angle-(Math.PI/64) - Math.PI/2));
	ctx.save();
	ctx.fillStyle= color;
	ctx.font = "10pt Arial";
	ctx.textAlign="center"; 
	ctx.fillText(ext,- taille/100*112*Math.cos(ext_angle - Math.PI/2),- taille/100*125*Math.sin(ext_angle  - Math.PI/2));
        ctx.fill();

	ctx.stroke();
	
	return ctx;
    }

    
    function print_nb(element_div, taille, taille_jauge, debut_jauge, type, born_min, born_max, min, max, avg, cur, avg_angle, cur_angle, contexte){
	
	if(contexte==true){
	    var mycanvas = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(mycanvas);
	    var ctx = mycanvas[0].getContext('2d');
	}else{
	    ctx = contexte;
	}
	// Print of graduation:
	ctx.beginPath();
	ctx.translate(taille*1.25,taille*1.25);
	ctx.save();
	// for (var i=0; i<8; i++){
	//     ctx.beginPath();
	//     ctx.fillStyle= "#303030";
	//     ctx.font = "10pt Arial";
	//     ctx.textAlign="center"; 
	//     var grad = (i*(born_max-born_min)/8) + born_min;
	//     ctx.fillText(Math.round(grad*10)/10,- taille/100*105*Math.cos(i*Math.PI/4 - Math.PI/2),- taille/100*105*Math.sin(i*Math.PI/4 - Math.PI/2));
	// }
	// ctx.save();


	ctx.beginPath();
	ctx.fillStyle= "#33cc00";
	ctx.font = "20pt Arial";
	ctx.textAlign="center"; 
	switch(type){
	case "Hygrometrie":
	    ctx.fillText("%",0,30);
	    break;
	case "Pression":
	    ctx.fillText("hPa",0,30);
	    break;
	}
	ctx.save();

	ctx.beginPath();
	ctx.fillStyle= "blue";
	ctx.font = "10pt Arial";
	if (min == born_min){
	    ctx.textAlign="right"; 
	}
	else{
	    ctx.textAlign="center"; 
	}
	ctx.fillText(min,- taille/100*110*Math.cos(debut_jauge - Math.PI/2),- taille/100*110*Math.sin(debut_jauge - Math.PI/2));
	ctx.save();

	ctx.beginPath();
	ctx.fillStyle= "red";
	ctx.font = "10pt Arial";
	if (max == born_max){
	    ctx.textAlign="left"; 
	}
	else{
	    ctx.textAlign="center"; 
	}
	ctx.fillText(max,- taille/100*110*Math.cos(debut_jauge+taille_jauge - Math.PI/2),- taille/100*110*Math.sin(debut_jauge+taille_jauge - Math.PI/2));
	ctx.save();

	ctx.beginPath();
	ctx.fillStyle= "orange";
	ctx.font = "10pt Arial";
	ctx.textAlign="center"; 
	ctx.fillText(avg,- taille/100*110*Math.cos(avg_angle - Math.PI/2),-taille/100*110*Math.sin(avg_angle - Math.PI/2));

	ctx.stroke();
    }
    
    function print_anneau(num){
	var canvas = document.getElementById("legende");
	var context = canvas.getContext("2d");
	
	if(num == 1){
	    context.beginPath();
	    context.strokeStyle = "orange";
	    context.lineWidth=4;	    
	    context.moveTo(48,70);
	    context.lineTo(82,70);
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

    // function print_legende(){
    // 	var canvas = document.getElementById("legende");
    // 	var context = canvas.getContext("2d");
	
    // 	context.beginPath();
    // 	var gradient = context.createLinearGradient(0, 0, 0, 100);
    // 	gradient.addColorStop("1","blue");
    // 	gradient.addColorStop("0.80","green");
    // 	gradient.addColorStop("0.20","orange");
    // 	gradient.addColorStop("0","red");
    // 	context.fillStyle = gradient;
    // 	context.fillRect(50, 0, 30, 100);
    // 	context.save();

    // 	context.beginPath();
    // 	context.fillStyle= "blue";
    // 	context.font = "12pt Calibri";
    // 	context.textAlign="rigth"; 
    // 	context.fillText("Donnée minimale de la journée dans votre maison",120, 99);
    // 	context.save();

    // 	context.beginPath();
    // 	context.fillStyle= "red";
    // 	context.font = "12pt Calibri";
    // 	context.textAlign="rigth"; 
    // 	context.fillText("Donnée maximale de la journée dans votre maison",120, 12)
    // 	context.save();

    // 	context.beginPath();
    // 	context.fillStyle= "orange";
    // 	context.font = "12pt Calibri";
    // 	context.textAlign="rigth"; 
    // 	context.fillText("Donnée moyenne de la journée dans votre maison",120, 75)
    // 	context.save();

    // 	context.beginPath();
    // 	context.fillStyle= "#33cc00";
    // 	context.font = "12pt Calibri";
    // 	context.textAlign="rigth"; 
    // 	context.fillText("Donnée actuelle de la journée dans votre maison",120, 45)

    // 	context.stroke();
    // 	return context;
	
    // }


    $('input.compteur').wrap('<div class="compteur" />').each(function(){

	var element_input = $(this); // le champs texte
	var element_div = element_input.parent(); // la div

	var type = element_input.data('type');
	var min = element_input.data('min');
	var max = element_input.data('max');
	var avg = element_input.data('avg');
	var cur = element_input.data('curin');
	var ext = element_input.data('curout');
	
	var out = ext ? (typeof ext == "number"): min 
	switch(type){
	case 'Pression':
	    var born_min = Math.min(940,min,out);
	    var born_max = Math.max(1060,max,out);
	    break;
	case 'Hygrometrie':
	    var born_min = Math.min(0,min,out);
	    var born_max = Math.max(100,max,out);
	    break;
	default:
	    var born_min = Math.min(0,min,out);
	    var born_max = Math.max(100,max,out);
	    break
	}
	
	var color = element_input.data('color') ? element_input.data('color') : "#33cc00"/*= vert*/ ;
	var taille = element_input.data('taille') ? element_input.data('taille') : 100 ;
	
	element_div.width(taille*2.5)
	    .height(taille*2.5);
	element_input.width(taille*2)
	    .css("font-size",(taille/100*40)+"px")
	    .css("top",(taille/100*85)+"px")
	    .css("left",(taille/100*25)+"px")
	    .css("color","#33cc00");
	
	var taille_jauge = 2*(Math.PI)*(max - min)/(born_max - born_min);
	var debut_jauge = 2*(Math.PI)*(min - born_min)/(born_max - born_min);
	var avg_angle = 2*(Math.PI)*(avg - born_min)/(born_max - born_min);
	var cur_angle = 2*(Math.PI)*(cur - born_min)/(born_max - born_min);
	

	//on dessine la jauge circulaire à l'aide du canevas
	print_gauge(element_div , taille , 2*Math.PI - taille_jauge, debut_jauge + taille_jauge, type , true , true,false);
	//on dessine le niveau de la jauge circulaire
	print_gauge(element_div , taille , taille_jauge, debut_jauge, type ,false , true, true);
	// Affichage de la donnée extérieur si elle existe:
	if (typeof ext == "number"){
	    var ext_angle = 2*(Math.PI)*(ext - born_min)/(born_max - born_min);
	    print_curext(element_div , taille ,taille_jauge, debut_jauge, ext, ext_angle, 'red' , true);
	}
	//on dessine les valeurs autour du cercle:
	print_avg(element_div , taille ,taille_jauge, debut_jauge, avg_angle, 'orange' , true);
	print_nb(element_div, taille, taille_jauge, debut_jauge, type, born_min, born_max, min, max, avg, cur, avg_angle, cur_angle, true);
	var contexte = print_curin(element_div , taille ,taille_jauge, debut_jauge, cur_angle, "#33cc00" , true);
	
    });
    
    //Legende si besoin:
    print_legende();
    print_anneau(1);   
    print_anneau(0);  
   
});

