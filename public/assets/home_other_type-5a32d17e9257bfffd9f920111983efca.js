jQuery(document).ready(function(t){function a(a,e,h,i,n,o,M,r){if(1==M){var s=t('<canvas width="'+2.5*e+'px" height="'+2.5*e+'px" />');a.append(s);var l=s[0].getContext("2d")}else l=M;if(l.beginPath(),l.translate(1.25*e,1.25*e),r)switch(n){case"Hygrometrie":var P=h/3,c=h/100,I=l.createLinearGradient(-e/100*80*Math.cos(i-Math.PI/2),-e/100*80*Math.sin(i-Math.PI/2),-e/100*80*Math.cos(i+P+c-Math.PI/2),-e/100*80*Math.sin(i+P+c-Math.PI/2));I.addColorStop("0","#87A5D8"),I.addColorStop("1","#1050BD"),l.arc(0,0,e/100*85,i+Math.PI/2,i+P+c+Math.PI/2,!1),l.lineWidth=e/100*20,l.strokeStyle=I,l.stroke(),l.save(),l.beginPath(),I=l.createLinearGradient(-e/100*80*Math.cos(i+P-Math.PI/2),-e/100*80*Math.sin(i+P-Math.PI/2),-e/100*80*Math.cos(i+2*P+c-Math.PI/2),-e/100*80*Math.sin(i+2*P+c-Math.PI/2)),I.addColorStop("0","#1050BD"),I.addColorStop("1","#11157F"),l.arc(0,0,e/100*85,i+P+Math.PI/2,i+2*P+c+Math.PI/2,!1),l.lineWidth=e/100*20,l.strokeStyle=I,l.stroke(),l.save(),l.beginPath(),I=l.createLinearGradient(-e/100*80*Math.cos(i+2*P-Math.PI/2),-e/100*80*Math.sin(i+2*P-Math.PI/2),-e/100*80*Math.cos(i+h-Math.PI/2),-e/100*80*Math.sin(i+h-Math.PI/2)),I.addColorStop("0","#11157F"),I.addColorStop("1","#010116"),l.arc(0,0,e/100*85,i+2*P+Math.PI/2,i+h+Math.PI/2,!1),l.lineWidth=e/100*20,l.strokeStyle=I,l.save();break;default:var P=h/3,c=h/100,I=l.createLinearGradient(-e/100*80*Math.cos(i-Math.PI/2),-e/100*80*Math.sin(i-Math.PI/2),-e/100*80*Math.cos(i+P+c-Math.PI/2),-e/100*80*Math.sin(i+P+c-Math.PI/2));I.addColorStop("0","blue"),I.addColorStop("1","green"),l.arc(0,0,e/100*85,i+Math.PI/2,i+P+c+Math.PI/2,!1),l.lineWidth=e/100*20,l.strokeStyle=I,l.stroke(),l.save(),l.beginPath(),I=l.createLinearGradient(-e/100*80*Math.cos(i+P-Math.PI/2),-e/100*80*Math.sin(i+P-Math.PI/2),-e/100*80*Math.cos(i+2*P+c-Math.PI/2),-e/100*80*Math.sin(i+2*P+c-Math.PI/2)),I.addColorStop("0","green"),I.addColorStop("1","orange"),l.arc(0,0,e/100*85,i+P+Math.PI/2,i+2*P+c+Math.PI/2,!1),l.lineWidth=e/100*20,l.strokeStyle=I,l.stroke(),l.save(),l.beginPath(),I=l.createLinearGradient(-e/100*80*Math.cos(i+2*P-Math.PI/2),-e/100*80*Math.sin(i+2*P-Math.PI/2),-e/100*80*Math.cos(i+h-Math.PI/2),-e/100*80*Math.sin(i+h+c-Math.PI/2)),I.addColorStop("0","orange"),I.addColorStop("1","red"),l.arc(0,0,e/100*85,i+2*P+Math.PI/2,i+h+Math.PI/2,!1),l.lineWidth=e/100*20,l.strokeStyle=I,l.save()}else l.strokeStyle="#303030",l.arc(0,0,e/100*85,i+Math.PI/2,h+i+Math.PI/2,!1),l.lineWidth=e/100*20;return o&&(l.shadowOffsetX=e/100*1.5,l.shadowBlur=e/100*8,l.shadowColor="rgba(0,0,0,0.5)"),l.stroke(),l}function e(a,e,h,i,n,o,M){if(1==M){var r=t('<canvas width="'+2.5*e+'px" height="'+2.5*e+'px" />');a.append(r);var s=r[0].getContext("2d")}else s=M;return s.translate(1.25*e,1.25*e),s.beginPath(),s.strokeStyle=o,s.lineWidth=4,s.moveTo(-e/100*73*Math.cos(n-Math.PI/2),-e/100*73*Math.sin(n-Math.PI/2)),s.lineTo(-e/100*97*Math.cos(n-Math.PI/2),-e/100*97*Math.sin(n-Math.PI/2)),s.stroke(),s}function h(a,e,h,i,n,o,M){if(1==M){var r=t('<canvas width="'+2.5*e+'px" height="'+2.5*e+'px" />');a.append(r);var s=r[0].getContext("2d")}else s=M;return s.beginPath(),s.translate(1.25*e,1.25*e),s.strokeStyle=o,s.globalAlpha=.65,s.lineWidth=3,s.moveTo(-e/100*75*Math.cos(n-Math.PI/2),-e/100*75*Math.sin(n-Math.PI/2)),s.lineTo(-e/100*65*Math.cos(n+Math.PI/32-Math.PI/2),-e/100*65*Math.sin(n+Math.PI/32-Math.PI/2)),s.moveTo(-e/100*75*Math.cos(n-Math.PI/2),-e/100*75*Math.sin(n-Math.PI/2)),s.lineTo(-e/100*65*Math.cos(n-Math.PI/32-Math.PI/2),-e/100*65*Math.sin(n-Math.PI/32-Math.PI/2)),s.stroke(),s}function i(a,e,h,i,n,o,M,r){if(1==r){var s=t('<canvas width="'+2.5*e+'px" height="'+2.5*e+'px" />');a.append(s);var l=s[0].getContext("2d")}else l=r;return l.beginPath(),l.translate(1.25*e,1.25*e),l.strokeStyle=M,l.globalAlpha=.6,l.lineWidth=3,l.moveTo(-e/100*95*Math.cos(o-Math.PI/2),-e/100*95*Math.sin(o-Math.PI/2)),l.lineTo(-e/100*105*Math.cos(o+Math.PI/64-Math.PI/2),-e/100*105*Math.sin(o+Math.PI/64-Math.PI/2)),l.moveTo(-e/100*95*Math.cos(o-Math.PI/2),-e/100*95*Math.sin(o-Math.PI/2)),l.lineTo(-e/100*105*Math.cos(o-Math.PI/64-Math.PI/2),-e/100*105*Math.sin(o-Math.PI/64-Math.PI/2)),l.save(),l.fillStyle=M,l.font="10pt helvetica_neuelight",l.textAlign="center",l.fillText(n,-e/100*112*Math.cos(o-Math.PI/2),-e/100*125*Math.sin(o-Math.PI/2)),l.fill(),l.stroke(),l}function n(a,e,h,i,n,o,M,r,s,l,P,c,I,d){if(1==d){var p=t('<canvas width="'+2.5*e+'px" height="'+2.5*e+'px" />');a.append(p);var g=p[0].getContext("2d")}else g=d;switch(g.beginPath(),g.translate(1.25*e,1.25*e),g.save(),g.beginPath(),g.fillStyle="#33cc00",g.font="20pt helvetica_neuelight",g.textAlign="center",n){case"Hygrometrie":g.fillText("%",0,30);break;case"Pression":g.fillText("hPa",0,30)}g.save(),g.beginPath(),g.fillStyle="blue",g.font="10pt helvetica_neuelight",g.textAlign=r==o?"right":"center",g.fillText(r,-e/100*110*Math.cos(i-Math.PI/2),-e/100*110*Math.sin(i-Math.PI/2)),g.save(),g.beginPath(),g.fillStyle="red",g.font="10pt helvetica_neuelight",g.textAlign=s==M?"left":"center",g.fillText(s,-e/100*110*Math.cos(i+h-Math.PI/2),-e/100*110*Math.sin(i+h-Math.PI/2)),g.save(),g.beginPath(),g.fillStyle="orange",g.font="10pt helvetica_neuelight",g.textAlign="center",g.fillText(l,-e/100*110*Math.cos(c-Math.PI/2),-e/100*110*Math.sin(c-Math.PI/2)),g.stroke()}t("input.compteur").wrap('<div class="compteur" />').each(function(){var o=t(this),M=o.parent(),r=o.data("type"),s=o.data("min"),l=o.data("max"),P=o.data("avg"),c=o.data("curin"),I=o.data("curout"),d=I?"number"==typeof I:s;switch(r){case"Pression":var p=Math.min(940,s,d),g=Math.max(1060,l,d);break;case"Hygrometrie":var p=Math.min(0,s,d),g=Math.max(100,l,d);break;default:var p=Math.min(0,s,d),g=Math.max(100,l,d)}var v=(o.data("color")?o.data("color"):"#33cc00",o.data("taille")?o.data("taille"):100);M.width(2.5*v).height(2.5*v),o.width(2*v).css("font-size",v/100*40+"px").css("top",v/100*85+"px").css("left",v/100*25+"px").css("color","#33cc00");var f=2*Math.PI*(l-s)/(g-p),x=2*Math.PI*(s-p)/(g-p),u=2*Math.PI*(P-p)/(g-p),S=2*Math.PI*(c-p)/(g-p);if(a(M,v,2*Math.PI-f,x+f,r,!0,!0,!1),a(M,v,f,x,r,!1,!0,!0),"number"==typeof I){var b=2*Math.PI*(I-p)/(g-p);i(M,v,f,x,I,b,"red",!0)}e(M,v,f,x,u,"orange",!0),n(M,v,f,x,r,p,g,s,l,P,c,u,S,!0),h(M,v,f,x,S,"#33cc00",!0)})});