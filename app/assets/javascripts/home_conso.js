$(document).on('page:change', function(){

    function print_gauge(element_div , taille , taille_jauge, debut_jauge, ombre, contexte, degrade){
	
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
	    
	    // Production of three part to create the gradient of the gauge:
	    var portion = taille_jauge/3;
	    var delta = taille_jauge/100;
	    // Creation of the gradient:
	    var gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge - Math.PI/2), - taille/100*80*Math.sin(debut_jauge - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + portion + delta - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + portion + delta - Math.PI/2));
	    // Choose of the colors for the gradient
	    gradient.addColorStop("0","white");
	    gradient.addColorStop("1","#EA9035");
	    // Print of an arc of circle
	    ctx.arc(0,0,(taille/100*85),  debut_jauge + Math.PI/2, debut_jauge + portion + delta +Math.PI/2,false); 
	    ctx.lineWidth = (taille/100*20);
	    ctx.strokeStyle = gradient;
	    ctx.stroke();
	    // saving of the actual drawing
	    ctx.save();

	    // We do the same for next parts
	    ctx.beginPath();
	    gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge + portion - Math.PI/2), - taille/100*80*Math.sin(debut_jauge + portion - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + 2*portion + delta - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + 2*portion + delta - Math.PI/2));
	    gradient.addColorStop("0","#EA9035");
	    gradient.addColorStop("1","#BF400A");
	    ctx.arc(0,0,(taille/100*85),  debut_jauge + portion + Math.PI/2, debut_jauge + 2*portion + delta + Math.PI/2,false); 
	    ctx.lineWidth = (taille/100*20);
	    ctx.strokeStyle = gradient;
	    ctx.stroke();
	    ctx.save();

	    ctx.beginPath();
	    gradient = ctx.createLinearGradient(- taille/100*80*Math.cos(debut_jauge + 2*portion - Math.PI/2), - taille/100*80*Math.sin(debut_jauge + 2*portion - Math.PI/2),- taille/100*80*Math.cos(debut_jauge + taille_jauge - Math.PI/2),- taille/100*80*Math.sin(debut_jauge + taille_jauge - Math.PI/2));
	    gradient.addColorStop("0","#BF400A");
	    gradient.addColorStop("1","red");
	    ctx.arc(0,0,(taille/100*85),  debut_jauge + 2*portion + Math.PI/2, debut_jauge + taille_jauge + Math.PI/2,false); 
	    ctx.lineWidth = (taille/100*20);
	    ctx.strokeStyle = gradient;
	    ctx.stroke();
	    ctx.save();
	}
	else{
	    // Color for the rest of the circle
	    ctx.strokeStyle = "#303030"; /*grey of ecobox*/
	    // Print of the rest of the circle:
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
    
    //Print of the current data ring
    function print_cur(element_div, taille, taille_jauge, debut_jauge, cur_angle, color, contexte){
	
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
	ctx.moveTo(- taille/100*73*Math.cos(cur_angle - Math.PI/2),- taille/100*73*Math.sin(cur_angle - Math.PI/2));
	ctx.lineTo(- taille/100*97*Math.cos(cur_angle - Math.PI/2),- taille/100*97*Math.sin(cur_angle - Math.PI/2));
	ctx.stroke();
	return ctx;
    }

// Print of the currency or the consumption unity:
    function print_devise(element_div, taille, contexte, aff){
	if(contexte===true){
	    var mycanvas = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(mycanvas);
	    var ctx = mycanvas[0].getContext('2d');
	    ctx.translate(taille*1.25,taille*1.25);
	}else{
	    ctx = contexte;
	}
	ctx.beginPath();
	ctx.fillStyle= "#33cc00";
	ctx.font = "20pt helvetica_neuelight";
	ctx.textAlign="center"; 
	if(aff){
	    ctx.fillText("€",0,40);
	}
	else{
	    ctx.fillText("Wh",0,40);
	}
	ctx.save();
	return ctx;
    }

    //Print of the value around the circle
    function print_nb(element_div, taille, taille_jauge, debut_jauge, born_min, born_max, min, max, cur, cum, cur_angle, cum_angle, contexte){
	
	if(contexte==true){
	    var mycanvas = $('<canvas width="'+(taille*2.5)+'px" height="'+(taille*2.5)+'px" />');
	    element_div.append(mycanvas);
	    var ctx = mycanvas[0].getContext('2d');
	}else{
	    ctx = contexte;
	}

	ctx.beginPath();
	ctx.translate(taille*1.25,taille*1.25);
	ctx.save();
	// // On affiche les valeurs autour du cercle:
	// for (var i=0; i<8; i++){
	//     ctx.beginPath();
	//     ctx.fillStyle= "#303030";
	//     ctx.font = "8pt helvetica_neuelight";
	//     ctx.textAlign="center"; 
	//     var grad = (i*(born_max-born_min)/8) + born_min;
	//     if (i == 4){
	// 	ctx.fillText(Math.round(grad*10)/10,- taille/100*103*Math.cos(i*Math.PI/4 - Math.PI/2),- taille/100*103*Math.sin(i*Math.PI/4 - Math.PI/2));
	//     }
	//     else {
	// 	ctx.fillText(Math.round(grad*10)/10,- taille/100*109*Math.cos(i*Math.PI/4 - Math.PI/2),- taille/100*109*Math.sin(i*Math.PI/4 - Math.PI/2));
	//     }
	// }
	// ctx.save();

	ctx.beginPath();
	ctx.fillStyle= "blue";
	ctx.font = "8pt helvetica_neuelight";
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
	ctx.font = "8pt helvetica_neuelight";
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
	ctx.font = "8pt helvetica_neuelight";
	ctx.textAlign="center"; 
	ctx.fillText(cur,- taille/100*110*Math.cos(cur_angle - Math.PI/2),-taille/100*110*Math.sin(cur_angle - Math.PI/2));

	ctx.stroke();
    }
    	
    $('input.conso').wrap('<div class="conso" />').each(function(){
	

	var element_input = $(this);
	var element_div = element_input.parent();
	
	// Get of the data:
	var min = element_input.data('min');
	var max = element_input.data('max');
	var cur = element_input.data('cur') ? element_input.data('cur') : min;
	var cum = element_input.data('cum');
	var born_min = Math.min(30,min);
	var born_max = Math.max(500,max);
	var color = element_input.data('color') ? element_input.data('color') : "#33cc00"/*= green*/ ;
	var taille = element_input.data('taille') ? element_input.data('taille') : 100 ;
	// booleen to manage the print of the currency or the consumption unity
	var aff = false;
	//  Cumulative value in euro:
	var cum_elec = Math.round(cum*0.00014*100)/100;
	
	// calcul of angles by values:
	var taille_jauge = 2*(Math.PI)*(max - min)/(born_max - born_min);
	var debut_jauge = 2*(Math.PI)*(min - born_min)/(born_max - born_min);
	var cur_angle = 2*(Math.PI)*(cur - born_min)/(born_max - born_min);
	var cum_angle = 2*(Math.PI)*(cum - born_min)/(born_max - born_min);


	// configuration of the text inside the circle
	element_div.width(taille*2.5)
	    .height(taille*2.5);
	element_input.width(130)
	    .css("font-size",(taille/100*40)+"px")
	    .css("top",(taille/100*90)+"px")
	    .css("left",(taille/100*60)+"px")
	    .css("text-align","center")
	    .css("color","#33cc00");
	

	// Print of the circle
	print_gauge(element_div , taille , 2*Math.PI - taille_jauge, debut_jauge + taille_jauge, true , true,false);
	// Print of the gauge
	print_gauge(element_div , taille , taille_jauge, debut_jauge,false , true, true);

	// Print of value around circle:
	print_cur(element_div , taille ,taille_jauge, debut_jauge, cur_angle, 'orange' , true);
	print_nb(element_div, taille, taille_jauge, debut_jauge, born_min, born_max, min, max, cur, cum, cur_angle, cum_angle, true);
	var contexte = print_devise(element_div, taille, true, aff);
	
	//Change of print by the mouse clic (€/Wh)
	element_div.mousedown(function(event){ 
	    event.preventDefault();	    
	    if (aff == false){
		aff = true;
		element_input.val(cum_elec);
	    }
	    else{
		aff = false;
	    	element_input.val(cum);
	    }
	    contexte.clearRect(-20,0,50,50);
	    print_devise(element_div, taille, contexte, aff);
	}).mouseup(function(event){
	    event.preventDefault();
	});	

	
    });   
});

