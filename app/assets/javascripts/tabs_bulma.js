function openTab(evt, tabName) {
  var content_tabs, tablinks;
  
  content_tabs = document.getElementsByClassName("content-tab");
  tablinks = document.getElementsByClassName("tab");

  for (var i = 0; i < content_tabs.length; i++) {
    content_tabs[i].style.display = "none";
  }
  
  for (var i = 0; i < content_tabs.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" is-active", "");
  }

  document.getElementById(tabName).style.display = "block";
  
  evt.currentTarget.className += " is-active";
}