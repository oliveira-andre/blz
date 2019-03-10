
$(document).on("turbolinks:load", function () {
  var curve_chart = document.getElementById('curve_chart');
  if(!curve_chart) return;
  load_chart(curve_chart);
});

function load_chart(element) {
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
    var data = google.visualization.arrayToDataTable([
      ['Semana', 'Fevereiro', 'Março'],
      ['1º semana',  1500, 1550],
      ['2º semana',  1170, 1870],
      ['3º semana',  660, 500],
      ['4º semana',  1030, 900]
    ]);

    var options = {
      title: 'Seus rendimentos',
      curveType: 'function',
      legend: { position: 'bottom' }
    };

    var chart = new google.visualization.LineChart(element);

    chart.draw(data, options);
  }
}