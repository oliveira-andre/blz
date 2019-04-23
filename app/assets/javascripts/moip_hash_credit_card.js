document.addEventListener("turbolinks:load", function() {
  $("#payment_form").submit(function(e){
    e.preventDefault();
    var form = this;
    if(check_credit_card()){
      form.submit();
    }
  });
});

function check_credit_card() {
  var cc = new Moip.CreditCard({
    number  : $("#card_number").val(),
    cvc     : $("#card_cvc").val(),
    expMonth: $("#expiration_month").val(),
    expYear : $("#expiration_year").val(),
    pubKey  : $("#public_key").val()
  });

  if( cc.isValid()){
    $("#card_hash").val(cc.hash());
    return true;
  }
  else{
    $("#card_hash").val('');
    alert('Cartão de crédito inválido. Verifique o número do cartão, código de segurança e data de validade.');
    return false;
  }
}