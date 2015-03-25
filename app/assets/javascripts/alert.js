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

  app.controller('AlertController',  ['$http', '$state', function($http, $state) {
    var scope = this;
    scope.alert = {};

    $http.get("/alerts/" + $state.params.alerta_id + ".json")
    .success(function(data){
      scope.alert = data.alert;
      console.log(scope.alert);
    });
  }]);


})();
