$(document).on("turbolinks:load", function () {
  if(!$('#filter-services-date')) return;

  bulmaCalendar.attach('#filter-services-date', {
    minDate: new Date(),
    startDate: new Date(),
    lang: 'pt-BR',
    dateFormat: 'DD/MM/YYYY',
    color: 'primary-color',
    cancelLabel: 'Cancelar',
    todayLabel: 'Hoje',
    showClearButton: false,
    enableYearSwitch: false,
    enableMonthSwitch: false
  });
});