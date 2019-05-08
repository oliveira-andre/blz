$(document).on("turbolinks:load", function () {
  runHomePage();
});

function runHomePage() {
  // RETURN IF NOT BE HOME PAGE
  if(!$('.pages-home')) return;

  // BULMA CALENDAR
  launchBulmaCalendar();

  // SCROLL TO SHOW FOOTER IN MOBILE
  scrollFooterShow();

  // SEARCH AND FILTERS
  listenerSearchAndFilter();
}

function listenerSearchAndFilter() {
  var eventTimeout = null;
  $('#query').keyup(function(e) {
    var query = $('#query').val();
    if(!(query && query.length >= 3)) return;

    if(eventTimeout) {
      clearTimeout(eventTimeout);
      eventTimeout = null;
    }
    eventTimeout = setTimeout(submitSearchAndFilters, 600);
  });
}

function submitSearchAndFilters() {
  $('#search-submit').click();
  toggleLoading();
}

function toggleLoading() {
  $('.field span img').toggleClass('is-hidden');
  $('.field .control').toggleClass('is-loading');
}

function launchBulmaCalendar() {
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
}

function scrollFooterShow() {
  $(window).scroll(function() {    
    var scroll = $(window).scrollTop();

    if (scroll >= 550) {
      $('footer.mobile').removeClass('is-hidden');
    } else {
      $('footer.mobile').addClass('is-hidden')
    }
  });
}