(function(){
  var app = angular.module('prolibertas-alert', ['ui.router']);

  app.controller('AlertsController', ['$http', '$state', function($http, $state){
    var scope = this;
    scope.alerts = [];

    $http.get("/people/" + $state.params.id + "/alerts.json")
      .success(function(data){
        scope.alerts = data.alerts;
      })
    scope.tipo = function(tipo){
      if (tipo == "punishment") {
        return 'castigo';
      }
      else if (tipo == "warning") {
        return 'advertencia';
      }
      else if (tipo == "advice") {
        return 'consejo';
      }
    }

  }])

})();
