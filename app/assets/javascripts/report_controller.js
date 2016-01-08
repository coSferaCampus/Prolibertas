(function() {
  var app = angular.module('prolibertas-report', ['ui.router']);

  // Controllers
  app.controller('ReportController', ['$filter', '$scope', function($filter, $scope) {
    var scope  = this;
    scope.this_year = $filter('date')(new Date(), 'yyyy');

    $('.datepicker').datetimepicker({locale: 'es', format: 'YYYY'});

    scope.getUrl = function() {
      if (scope.reportOption) {
        var url    = "";
        var option = Number(scope.reportOption);

        switch(option) {
          case 0:
            url = '/reports/type.json?selected_year=' + $("#SelectedYear").val();
            break;
          case 1:
            url = '/reports/age_range?selected_year=' + $("#SelectedYear").val();
            break;
          default:
            url = '/aaaaaaaa?selected_year=' + $("#SelectedYear").val();
        }


        location.href = url;
      }
    };
  }]);
})();
