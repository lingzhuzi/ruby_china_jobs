$(function(){

  initDatePickers();
  bindEvents();
  doSubmit();

  function initDatePickers(){
    var today = new Date();
    var startDate = new Date(2011, 9);
    var endDate = new Date(today.getFullYear(), today.getMonth() + 2);
    var yearOptions = {
      language:  'zh-CN',
      autoclose: 1,
      minView: 4,
      startView: 4,
      forceParse: 0,
      startDate: startDate,
      endDate: endDate
    };
    $('#year_from').datetimepicker(yearOptions);
    $('#year_to').datetimepicker(yearOptions);

    var monthOptions = $.extend({}, yearOptions, {
      minView: 3
    });
    $('#month_from').datetimepicker(monthOptions);
    $('#month_to').datetimepicker(monthOptions);

    $('#year_from').datetimepicker('setDate', startDate);
    $('#year_to').datetimepicker('setDate', today);

    $('#month_from').datetimepicker('setDate', startDate);
    $('#month_to').datetimepicker('setDate', today);
  }

  function bindEvents(){
    $(document).on('change', '#report_type', function(){
      var value = $(this).val();
      if (value == 'year') {
        $('#year_from').show();
        $('#year_to').show();
        $('#month_from').hide();
        $('#month_to').hide();
      } else if (value == 'month') {
        $('#year_from').hide();
        $('#year_to').hide();
        $('#month_from').show();
        $('#month_to').show();
      }
    });

    $(document).on('click', '#draw_report', function(){
      doSubmit();
    });
  }

  function doSubmit(){
    var reportType = $('#report_type').val();
    var from, to;
    if (reportType == 'year') {
      from = $('#year_from').datetimepicker('getFormattedDate');
      to = $('#year_to').datetimepicker('getFormattedDate');
    } else if (reportType == 'month') {
      from = $('#month_from').datetimepicker('getFormattedDate');
      to = $('#month_to').datetimepicker('getFormattedDate');
    }
    loadReportData(reportType, from, to, drawReport);
  }

  function loadReportData(reportType, from, to, callback){
    $('#canvas_ctn').children().remove();
    $.get('/reports/' + reportType, {from: from, to: to}, function(reports){
      callback.call(null, reports);
    }, 'json');
  }

  function drawReport(reports){
    var cities = ['北京', '上海', '广州', '深圳'];
    var data = {}, categories = [], series = [], report, city, jobNum;

    for(var i=0;i<reports.length;i++){
      report = reports[i];
      city = report.city;
      jobNum = report.job_num;
      if(data[city]){
        data[city].push(jobNum);
      } else {
        data[city] = [jobNum];
      }
      if(categories.indexOf(report.name) == -1){
        categories.push(report.name);
      }
    }
    for(var name in data){
      series.push({
        name: name,
        data: data[name],
        visible: cities.indexOf(name) > -1 // 隐藏部分曲线
      });
    }
    $('#canvas_ctn').append($('<div id="container"></div>'));

    $('#container').highcharts({
      title: {
        text: 'Ruby China Topics',
        x: -20 //center
      },
      subtitle: {
        text: '',
        x: -20
      },
      xAxis: {
        categories: categories
      },
      yAxis: {
        title: {
          text: 'Topics'
        },
        plotLines: [{
          value: 0,
          width: 1,
          color: '#808080'
        }]
      },
      tooltip: {
        valueSuffix: ''
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      },
      series: series,
      // 隐藏Highcharts.com
      credits: {
        enabled: false
      },
      exporting: {
        enabled: true
      }
    });
  }
});