document.addEventListener('turbolinks:load', () => {
  bulmaStepAttach();
});


function bulmaStepAttach() {
  //PAGES TO ATTACH BULMA STEPS
  const pages = [
    'establishments-new',
    'establishments-edit'
  ]

  pages.forEach(function(page) {
    var page = $(`.${page}`);
    if(page.length > 0) bulmaSteps.attach();
  });
}
