// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){

  bindEvents();
  drawTotalReport();

  function bindEvents(){
    $(document).on('change', '#report_type', function(){
      var value = $(this).val();
      if(value == 'total'){
        $('#year_col').hide();
        $('#month_col').hide();
      } else if (value == 'year') {
        $('#year_col').show();
        $('#month_col').hide();
      } else if (value == 'month') {
        $('#year_col').show();
        $('#month_col').show();
      }
    });

    $(document).on('click', '#draw_report', function(){
      var reportType = $('#report_type').val();
      if (reportType == 'total'){
        drawTotalReport();
      } else if (reportType == 'year') {
        var year = $('#year').val();
        drawYearReport(year);
      } else if (reportType == 'month') {
        var year = $('#year').val();
        var month = $('#month').val();
        drawMonthReport(year, month);
      }
    });
  }

  function drawTotalReport(){
    var url = '/reports/total';
    var data = {};
    loadData(url, data, drawReport);
  }

  function drawYearReport(year) {
    var url = '/reports/year';
    var data = {from: year, to: year};
    loadData(url, data, drawReport);
  }

  function drawMonthReport(year, month) {
    var from = year + '-' + month;
    var url = '/reports/month';
    var data = {from: from, to: from};
    loadData(url, data, drawReport);
  }

  function loadData(url, data, callback) {
    $.get(url, data, function(reports){
      var cities = [];
      var jobNums = [];
      var report;
      for(var i=0;i<reports.length;i++){
        report = reports[i];
        cities.push(report.city);
        jobNums.push(report.job_num);
      }
      callback.call(null, cities, jobNums);
    }, 'json');
  }

  function drawReport(cities, jobNums){
    var $chart = $('<canvas width="800" height="400"></canvas>');
    var $ctn = $('#canvas_ctn');
    $ctn.children().remove();
    $ctn.append($chart);

    var ctx = $chart.get(0).getContext("2d");
    var chart = new Chart(ctx);

    var data = {
      labels : cities,
      datasets : [
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(220,220,220,1)",
          data : jobNums
        }
      ]
    };
    chart.Bar(data);
  }

});