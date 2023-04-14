$(window).on('load', function () {
  "use strict";

	$(".loader").fadeOut();
  $("#preloder").delay(200).fadeOut("slow");


  $(".search-switch").on("click", function () {
    $(".search-model").fadeIn(400);
  });

  $(".search-close-switch").on("click", function () {
    $(".search-model").fadeOut(400, function () {
      $("#search-input").val("");
    });
  });

  $("#scrollToTopButton").click(function() {
      $("html, body").animate({ scrollTop: 0 }, "slow");
      return false;
   });
  /*------------------
      FIlter
  --------------------*/
  $('.filter__controls li').on('click', function () {
      $('.filter__controls li').removeClass('active');
      $(this).addClass('active');
  });

  if ($('.filter__gallery').length > 0) {
      var containerEl = document.querySelector('.filter__gallery');
      var mixer = mixitup(containerEl);
  }
});
