$(document).on("turbolinks:load", function () {
  runHomePage();
});

function runHomePage(filter_date) {
  // RETURN IF NOT BE HOME PAGE
  if(!$('.pages-home')) return;

  // BULMA CALENDAR
  launchBulmaCalendar(filter_date);

  // SCROLL TO SHOW FOOTER IN MOBILE
  scrollFooterShow();

  // SEARCH AND FILTERS
  listenerSearchAndFilter();
}

function listenerSearchAndFilter() {
  var eventTimeout = null;

  $('#query').keyup(function(e) {
    if(eventTimeout) {
      clearTimeout(eventTimeout);
      eventTimeout = null;
    }
    eventTimeout = setTimeout(function() {
      $('#search-submit').click();
      toggleLoading();
    }, 600);
  });

  $('input[name="local_type[]"], input[name="categories_ids[]"]').change(function(e){
    if(e.target.name == "categories_ids[]") {
      e.target.parentElement.classList.toggle('is-active');
      $(e.target.parentElement.children[1]).toggleClass('button is-loading is-size-3')
      e.target.parentElement.children[1].children[0].classList.toggle('is-hidden')
    }

    if(eventTimeout) {
      clearTimeout(eventTimeout);
      eventTimeout = null;
    }

    eventTimeout = setTimeout(function() {
      $('#filters-submit').click();
    }, 600);
  });

  const datepicker = document.querySelector('#home_filter_date');

  if (datepicker) {
    datepicker.bulmaCalendar.on('select', function() {
      if(eventTimeout) {
        clearTimeout(eventTimeout);
        eventTimeout = null;
      }

      eventTimeout = setTimeout(function() {
        $('#filters-submit').click();
      }, 600);
    });
  }
}

function toggleLoading() {
  $('.field span img').toggleClass('is-hidden');
  $('.field .control').toggleClass('is-loading');
}

function launchBulmaCalendar(filter_date) {
  bulmaCalendar.attach('#home_filter_date', {
    minDate: new Date(),
    lang: 'pt-BR',
    startDate: dateFormartPTBR(filter_date),
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

function dateFormartPTBR(date) {
    if(!date) return '';

    separeted_date = date.split("/")
    day = parseInt(separeted_date[0]);
    month = parseInt(separeted_date[1]) - 1;
    year = parseInt(separeted_date[2]);

    date = new Date();
    date.setDate(day);
    date.setMonth(month);
    date.setYear(year);
    return date;
}