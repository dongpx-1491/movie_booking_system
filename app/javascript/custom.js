$(document).on('ready', function(){
  $('#q_s').on('change', function(){
    $(this).closest("form").submit();
  })
});
