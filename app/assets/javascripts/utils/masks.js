$(document).on("turbolinks:load", function () {
  loadMasks();
});

function loadMasks(){
  $(".cpf").mask("000.000.000-00", {reverse: true});
  $(".phone").mask("(00) 0 0000-0000");
  $(".zipcode").mask("00000-000");
}