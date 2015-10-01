// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var $win = $(window);

$(document).ready(function() {
  $('#sign-up-btn').click( function() {
    $('html, body').animate({
      scrollTop: $(".wrapper").offset().top
    }, 1000);
  });
});

if(window.innerWidth <= 600) {
  var bg = jQuery("body");
  jQuery(window).resize("resizeBackground");
  function resizeBackground() {
    bg.height(jQuery(window).height());
  }
  resizeBackground();
}



$(document).ready(function() {
  if(screen.height <= 720) {
    document.getElementById('homeheader').height = 0.9 * screen.height;
  }
});
