function openTab(evt, tabName) {
  var content_tabs, tablinks;
  
  content_tabs = document.getElementsByClassName("content-tab");
  tablinks = document.getElementsByClassName("tab");

  for (var i = 0; i < content_tabs.length; i++) {
    content_tabs[i].style.display = "none";
  }
  
  for (var i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" is-active", "");
  }

  var tabContent = document.getElementById(tabName);
  if(tabContent) tabContent.style.display = "block";
  
  evt.currentTarget.className += " is-active";
}

$(document).on("turbolinks:load", function () {
  var tabs = document.querySelectorAll('.tab');
  if(tabs.length <= 0) return;

  tabs.forEach(function(tab){
    tab.addEventListener('click', function(e){
      var element = e.currentTarget;
      var tabTarget = element.dataset.target;
      openTab(e, tabTarget);
    });
  });
});

$(document).on("turbolinks:request-start", function () {
  var tabs = document.getElementsByClassName("tab");

  for (var i = 0; i < tabs.length; i++) {
    tabs[i].className = tabs[i].className.replace(" is-active", "");
  }
});
