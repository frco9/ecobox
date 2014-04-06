// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs 
//= require turbolinks
//= require bootstrap
//= require bootstrap-switch
//= require jqBootstrapValidation
$(document).on('page:change', function(){
  $("input,select,textarea").not("[type=submit]").jqBootstrapValidation();
  $("#menu-switch").click(function() {
    if ($("#foreground").css("left")=="0px") {
      $("#foreground").css("left", "0px").removeClass("left-offset");
      $("#foreground").animate({left: "-142px"}, 400, function()
      {
        $(this).removeAttr('style');
      });
      $("#wrap").css("left", "150px").removeClass("main-offset");
      $("#wrap").animate({left: "8px"}, 400, function()
      {
        $(this).removeAttr('style');
      });
    }else{
      $("#foreground").animate({left: "0px"}, 400, function()
      {
        $(this).addClass("left-offset").removeAttr('style');
      });
      $("#wrap").animate({left: "150px"}, 400, function()
      {
        $(this).addClass("main-offset").removeAttr('style');
      });
    }
  });
});