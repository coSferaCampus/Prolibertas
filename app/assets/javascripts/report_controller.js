(function() {
  var app = angular.module('prolibertas-report', ['ui.router']);

  // Controllers
  app.controller('ReportController', ['$filter', '$scope', function($filter, $scope) {
    var scope = this;
    scope.this_year = $filter('date')(new Date(), 'yyyy');

    $('.datepicker').datetimepicker({locale: 'es', format: 'YYYY'});

    scope.getUrl = function() {
      if (scope.reportOption >= 0 && scope.reportOption <= 7) {
        var url = "";
        var option = Number(scope.reportOption);

        switch(option) {
          case 0:
            url = '/reports/type.json?selected_year=' + $("#SelectedYear").val();
            break;
          case 1:
            url = '/reports/age?selected_year=' + $("#SelectedYear").val();
            break;
          case 2:
            url = '/reports/city?selected_year=' + $("#SelectedYear").val();
            break;
          case 3:
            url = '/reports/origin?selected_year=' + $("#SelectedYear").val();
            break;
        }

        location.href = url;
      }
    };
  }]);
})();
