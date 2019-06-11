$(document).on('turbolinks:load', function () {
  $('.input').keyup(function () {
    enableSaveButton();
  });
});

function enableSaveButton() {
  if (cardNumber().length == 19 && holderName().length != 0 &&
    holderCpf().length == 14 && expirationMonth().length == 2 &&
    expirationYear().length == 2 && cvv().length == 3) {
    $('input[type=submit]').prop('disabled', false);
    createHash();
  }
}

function createHash() {
  var cc = new Moip.CreditCard({
    number: cardNumber(),
    cvc: cvv(),
    expMonth: expirationMonth(),
    expYear: expirationYear(),
    pubKey: publicKey()
  });
  console.log('correct');
  template_string = `<input id='payment_card_hash_card'
    value='${cc.hash()}' class='is-hidden' name='payment_card[hash_card]'>`;
  $('#encrypted_value').replaceWith(template_string);
}

function cardNumber() {
  return $('#payment_card_number').val();
}

function holderName() {
  return $('#payment_card_holder_name').val();
}

function holderCpf() {
  return $('#payment_card_holder_cpf').val();
}

function expirationMonth() {
  return $('#payment_card_expiration_month').val();
}

function expirationYear() {
  return $('#payment_card_expiration_year').val();
}

function cvv() {
  return $('#payment_card_cvv').val();
}

function publicKey() {
  return $('#payment_card_public_key').val();
}