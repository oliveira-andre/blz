$(document).on("turbolinks:load", function () {

  //OPEN BULMA CALENDAR
  bulmaCalendar.attach('#home_filter_date', {
    minDate: new Date(),
    lang: 'pt',
    dateFormat: 'DD/MM/YYYY',
    color: '$primary-color',
    cancelLabel: 'Cancelar',
    todayLabel: 'Hoje',
    showClearButton: false,
    enableYearSwitch: false,
    enableMonthSwitch: false
  });

  //SCROLL TO SHOW FOOTER IN MOBILE
  $(window).scroll(function() {    
    var scroll = $(window).scrollTop();

    if (scroll >= 550) {
      $('footer').removeClass('is-hidden');
    } else {
      $('footer').addClass('is-hidden')
    }
  });
});