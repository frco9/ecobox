jQuery(document).ready(function($){

    function dessin_jauge(element_div , taille , min, max, born_min, born_max, avg, cur, color , ombre, contexte, with_mark){
	
	if(contexte===true){
	    
	    var circle = $('<canvas width="'+(taille*2)+'px" height="'+(taille*2)+'px" />');
	    element_div.append(circle);
	    // on configure notre plan de travail : 2 dimentions
	    var ctx = circle[0].getContext('2d');
	    
	}else{
	    
	    ctx = contexte;
	    
	}

	var ratio = (max - min)/(born_max - born_min)*2*Math.PI;
	var debut_jauge = (Math.PI)*((1/2) + 2*(min - born_min)/(born_max - born_min));
	
	
	if(with_mark){
	    var avg_angle = (avg/(born_max - born_min))*2*Math.PI + debut_jauge + ratio;
	    var cur_angle = (cur/(born_max - born_min))*2*Math.PI + debut_jauge + ratio;
	    ctx.beginPath();
	    ctx.strokeStyle= color;
	    ctx.lineWidth=4;	    
	    // avg line:
	    ctx.moveTo(taille - taille/100*73*Math.cos(avg_angle), taille - taille/100*73*Math.sin(avg_angle));
	    ctx.lineTo(taille - taille/100*97*Math.cos(avg_angle), taille - taille/100*97*Math.sin(avg_angle));

	    //current arrow:
	    ctx.moveTo(taille - taille/100*50*Math.cos(cur_angle), taille - taille/100*50*Math.sin(cur_angle));
	    ctx.lineTo(taille - taille/100*73*Math.cos(cur_angle), taille - taille/100*73*Math.sin(cur_angle));

	    ctx.moveTo(taille - taille/100*73*Math.cos(cur_angle), taille - taille/100*73*Math.sin(cur_angle));
	    ctx.lineTo(taille - taille/100*73*Math.cos(cur_angle), taille - taille/100*73*Math.sin(cur_angle));
	    
	}else{
	    // début du dessin
	    ctx.beginPath();
	    // on dessine un cercle
	    ctx.arc(taille,taille,(taille/100*85),  debut_jauge, ratio + debut_jauge); 
	    // taille du bord
	    ctx.lineWidth = (taille/100*20);
	    //couleur du bord
	    ctx.strokeStyle = color;
	    
	}
	
	if(ombre){
	    
	    //position de l'ombre
	    ctx.shadowOffsetX = (taille/100*1.5);
	    // taille de l'ombre
	    ctx.shadowBlur = (taille/100*8);
	    //couleur de l'ombre
	    ctx.shadowColor='rgba(0,0,0,0.5)';
	    
	}
	
	//fin du dessin
	ctx.stroke();
	
	return ctx;
    }

    
    // on entour le champs texte avec une Div qui contiendra notre jauge
    $('input.compteur').wrap('<div class="compteur" />').each(function(){
	
	// initialisation des variables
	var element_input = $(this); // le champs texte
	var element_div = element_input.parent(); // la div
	// on récupère la valeur minimum de la jauge
	var min = element_input.data('min');
           
	// le maximum
	var max = element_input.data('max');
	// la moyenne
	var avg = element_input.data('avg');
	// et l'actuel
	var cur = element_input.data('cur');

        var born_min = 0;
	var born_max = 60;

	if (min < 0){
	    born_min = min;
	}
        
	if (max > 60){
	    born_max = max;
	}
	//la couleur de la jauge
	var color = element_input.data('color') ? element_input.data('color') : "#33cc00" ;
	// sa taille
	var taille = element_input.data('taille') ? element_input.data('taille') : 100 ;
	// on récupère la valeur par défaut de la jauge et la transporme en pourcentage
	// on met en forme la div et le champs texte
	element_div.width(taille*2)
	    .height(taille*2);
	element_input.width(taille)
	    .css("font-size",(taille/100*40)+"px")
	    .css("top",(taille/100*70)+"px")
	    .css("left",(taille/100*50)+"px");
	
	//on dessine la jauge circulaire à l'aide du canevas
	dessin_jauge(element_div , taille , born_min, born_max, born_min, born_max, avg, cur,"#303030" , true , true, false);
	//on dessine le niveau de la jauge circulaire
	dessin_jauge(element_div , taille , min ,max, born_min, born_max, avg, cur, color ,false , true, false);
	//on dessine affiche la moyenne sur la jauge
	var contexte = dessin_jauge(element_div , taille , min ,max, born_min, born_max, avg, cur, 'red' , false , true, true);
	
    });

});
