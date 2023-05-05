/*  ---------------------------------------------------
    Theme Name: Anime
    Description: Anime video tamplate
    Author: Colorib
    Author URI: https://colorib.com/
    Version: 1.0
    Created: Colorib
---------------------------------------------------------  */
$(document).on('ready', function(){


     /*------------------
         Background Set
     --------------------*/
     $('.set-bg').each(function () {
         var bg = $(this).data('setbg');
         $(this).css('background-image', 'url(' + bg + ')');
     });

     // Search model



     /*------------------
     Navigation
   --------------------*/
     $(".mobile-menu").slicknav({
         prependTo: '#mobile-menu-wrap',
         allowParentLinks: true
     });

     /*------------------
     Hero Slider
   --------------------*/
     var hero_s = $(".hero__slider");
     hero_s.owlCarousel({
         loop: true,
         margin: 0,
         items: 1,
         dots: true,
         nav: true,
         navText: ["<i class='fa-solid fa-chevron-left'></i>", "<i class='fa-solid fa-chevron-right'></i>"],
         animateOut: 'fadeOut',
         animateIn: 'fadeIn',
         smartSpeed: 1200,
         autoHeight: false,
         autoplay: true,
         mouseDrag: false
     });

     /*------------------
         Video Player
     --------------------*/
     const player = new Plyr('#player', {
         controls: ['play-large', 'play', 'progress', 'current-time', 'mute', 'captions', 'settings', 'fullscreen'],
         seekTime: 25
     });

     /*------------------
         Niceselect
     --------------------*/
    //  $('select').niceSelect();

     /*------------------
         Scroll To Top
     --------------------*/
     $("#scrollToTopButton").click(function() {
         $("html, body").animate({ scrollTop: 0 }, "slow");
         return false;
      });
  });
