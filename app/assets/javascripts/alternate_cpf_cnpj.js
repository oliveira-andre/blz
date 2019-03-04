$(document).on("turbolinks:load", function () {
  masks();
  $("input[name=cpf_cnpj]").change(function () {
    if (this.value == "CNPJ") {
      $("#cpf_cnpj").removeClass("cpf");
      $("#cpf_cnpj").addClass("cnpj");
      $("#label_cpf_cnpj").remove();
      $(`<label class="label is-uppercase" id="label_cpf_cnpj" for="establishment_CPF">
            CNPJ
         </label>`).insertBefore("#cpf_cnpj");
    } else {
      $("#cpf_cnpj").removeClass("cnpj");
      $("#cpf_cnpj").addClass("cpf");
      $("#label_cpf_cnpj").remove();
      $(`<label class="label is-uppercase" id="label_cpf_cnpj" for="establishment_CPF">
            CPF
         </label>`).insertBefore("#cpf_cnpj");
    }
    masks();
  });
});

function masks() {
  $(".cpf").mask("000.000.000-00", {reverse: true});
  $(".cnpj").mask("00.000.000/0000-00", {reverse: true});
  $(".phone").mask("(00) 0 0000-0000");
  $(".cep").mask("00000-000");
}