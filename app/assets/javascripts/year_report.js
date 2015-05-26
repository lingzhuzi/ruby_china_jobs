$(function(){

  initDatePickers();

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
      minView: 3,
      startView: 4
    });
  }

});