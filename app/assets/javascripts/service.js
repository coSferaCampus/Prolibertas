(function(){
  var app = angular.module('prolibertas-service', ['ui.router']);
  app.controller('ServicesController', ['$http', '$state', '$timeout', '$rootScope', function($http, $state, $timeout, $rootScope) {
    var scope         = this;
    scope.services    = [];
    scope.serviceForm = {};
    scope.errors      = {};

    scope.alertaCreado = $state.params.alertaCreado;
    // La alerta se oculta después de 5 segundos
    $timeout(function() { scope.alertaCreado = false; }, 1000);

    scope.alertaBorrado = $state.params.alertaBorrado;
    // La alerta se oculta después de 5 segundos
    $timeout(function() { scope.alertaBorrado = false; }, 1000);

    $http.get('/services.json').success(function(data) {
        scope.services = data.services;
    });

    scope.change = function(field) {
      if(scope.errors[field.toLowerCase()]) {
        $("#Input" + field).tooltip('destroy');
        scope.errors[field.toLowerCase()] = false
      }
    };

    scope.guardarServicio = function() {
      scope.serviceForm.primary = false;
      $http.post('/services.json', {service: scope.serviceForm}).success(function(data) {
        scope.services.push(data.service);
        $state.go('servicios', { alertaCreado: 'true' });
        scope.errors = {};
        scope.serviceForm = {};
      }).error(function(data) {
        scope.errors = data.errors;

        for(var error in scope.errors) {
          if(scope.errors[error]) {
            $("#Input" + $rootScope.capitalize(error))
              .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
          }
        }
      });
    };

    scope.destroyService = function(service) {
      var confirmed = confirm('¿Desea borrar a el servicio?');
      if (confirmed) {
        $http.delete('/services/' + service.id + '.json').success(function(data) {
          //busco el indice del array que contiene el objeto service
          var index = scope.services.indexOf(service);
          //borra la posicion index del array
          scope.services.splice(index, 1);
        });
      }
    };

  }]);
})();
