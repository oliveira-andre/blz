$(document).on('turbolinks:load', function () {
  $('.input').keyup(function () {
    createHash();
  });
});

function createHash() {
  var cc = new Moip.CreditCard({
    number: getCardNumber(),
    cvc: getCvv(),
    expMonth: getExpirationMonth(),
    expYear: getExpirationYear(),
    pubKey: getPublicKey()
  });
  if (cc.isValid()) {
    $('input[type=submit]').prop('disabled', false);
    template_string = `<input id='payment_card_hash_card'
    value='${cc.hash()}' class='is-hidden' name='payment_card[hash_card]'>`;
    $('#encrypted_value').replaceWith(template_string);
  }
}

function getCardNumber() {
  return $('#payment_card_number').val();
}

function getHolderName() {
  return $('#payment_card_holder_name').val();
}

function getHolderCpf() {
  return $('#payment_card_holder_cpf').val();
}

function getExpirationMonth() {
  return $('#payment_card_expiration_month').val();
}

function getExpirationYear() {
  return $('#payment_card_expiration_year').val();
}

function getCvv() {
  return $('#payment_card_cvv').val();
}

function getPublicKey() {
  return $('#payment_card_public_key').val();
}