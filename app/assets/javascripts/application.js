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
//= require bootstrap-sprockets
//= require turbolinks
//= require highcharts
//= require_tree .

var ready;
ready = function() {

// Menu
$("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });

// FAQs
   $('#faq a.title').click(function(e) {
    e.preventDefault();
    $(this).parent().toggleClass('active', !$(this).parent().hasClass('active'));
    $(this).next('.answer').slideToggle();
  });
//Filter
   $('#filterOptions li a').click(function() {
    // fetch the class of the clicked item
    var ourClass = $(this).attr('class');

    // reset the active class on all the buttons
    $('#filterOptions li').removeClass('active');
    // update the active state on our clicked button
    $(this).parent().addClass('active');

    if(ourClass == 'all') {
      // show all our items
      $('#teamHolder').children('div.item').show();
    }
    else {
      // hide all elements that don't share ourClass
      $('#teamHolder').children('div:not(.' + ourClass + ')').hide();
      // show all elements that do share ourClass
      $('#teamHolder').children('div.' + ourClass).show();
    }
    return false;
  });

   // Image Hover
   $("[rel='tooltip']").tooltip();    
 
    $('.thumbnail').hover(
        function(){
            $(this).find('.caption').slideDown(250); //.fadeIn(250)
        },
        function(){
            $(this).find('.caption').slideUp(250); //.fadeOut(205)
        }
    ); 


    // Scrolling
  $(window).on('scroll', function() {
    var y_scroll_pos = window.pageYOffset;
    var scroll_pos_test = 40;

    if(y_scroll_pos > scroll_pos_test) {
        $('.nav').css('margin-top','-60px');
        $('.pill-wrapper').css('display','inline-block');
    }else{
    $('.nav').css('margin-top','0px');
    $('.pill-wrapper').css('display','none');

    }
});




    };

$(document).ready(ready);
$(document).on('page:load', ready);