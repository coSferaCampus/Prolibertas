(function(){
  var app = angular.module('prolibertas-alert', ['ui.router']);

  app.controller('AlertsController', ['$http', '$timeout', '$state', function($http, $timeout, $state) {
    var scope = this;
    scope.alerts = [];
    scope.alertaCreado = $state.params.alertaCreado;

    // La alerta se oculta después de 3 segundos
    $timeout(function(){scope.alertaCreado = false;}, 5000);

    scope.alertaBorrado = $state.params.alertaBorrado;
    // La alerta se oculta después de 3 segundos
    $timeout(function(){scope.alertaBorrado = false;}, 5000);


    $http.get("/people/" + $state.params.id + "/alerts.json")
      .success(function(data){
        scope.alerts = data.alerts;
      })

    scope.tipo = function(tipo){
      if (tipo == "punishment") {
        return 'sanción';
      }
      else if (tipo == "warning") {
        return 'advertencia';
      }
      else if (tipo == "advice") {
        return 'consejo';
      }
    }

    scope.alertClass = function(alert) {
      if (alert.type == 'punishment') {
        return 'danger';
      }
      else if (alert.type == 'warning') {
        return 'warning';
      }
      else if (alert.type == 'advice') {
        return 'success';
      }
      else {
        return '';
      }
    };

  }]);

  app.controller('AlertController',  ['$http', '$state', function($http, $state) {
    var scope = this;
    scope.alert = {};

    $http.get("/alerts/" + $state.params.alerta_id + ".json")
    .success(function(data){
      scope.alert = data.alert;
      console.log(scope.alert);
    })

    scope.tipo = function(tipo){
      if (tipo == "punishment") {
        return 'sanción';
      }
      else if (tipo == "warning") {
        return 'advertencia';
      }
      else if (tipo == "advice") {
        return 'consejo';
      }
    };

    scope.destroyAlert = function(alert) {
      var confirmed = confirm('¿Desea borrar la alerta?');
      if (confirmed) {
        $http.delete('/alerts/' + $state.params.alerta_id + '.json').success(function(data) {
          $state.go("persona.alertas", { alertaBorrado: 'true' })
        });
      }
    };

  }]);

  app.controller('AlertFormController', ['$http', '$state', '$rootScope',function($http, $state, $rootScope) {
    var scope = this;
    // variable para el formulario
    scope.alertForm = {};
   //variable para los errores
    scope.errors = {};

    $('.datepicker').datetimepicker({locale: 'es', format: 'L'});

    scope.change = function(field) {
      if(scope.errors[field.toLowerCase()]) {
        $("#Input" + field).tooltip('destroy');
        scope.errors[field.toLowerCase()] = false
      }
    };

    scope.formDates = function(){
      scope.alertForm.pending = $('#InputPending').val();
    };

    scope.guardarAlerta = function() {
      scope.formDates();
      $http.post('/people/' + $state.params.id + '/alerts.json', {alert: scope.alertForm})
        .success(function(data){
          $state.go('persona.alertas', { id: $state.params.id, alertaCreado: 'true' });
        })
        .error(function(data) {
          scope.errors = data.errors;

          for(var error in scope.errors) {
            if(scope.errors[error]) {
              $("#Input" + $rootScope.capitalize(error))
                .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
            }
          }
        });
    };

    scope.actualizarAlerta = function() {
      scope.formDates();
      $http.put("/alerts/" + $state.params.alerta_id + ".json",{alert: scope.alertForm})
        .success(function() {
          $state.go("persona.alerta", {alerta_id: $state.params.alerta_id});
          scope.errors = {};
        })
        .error(function(data) {
          scope.errors = data.errors;

          for(var error in scope.errors) {
            if(scope.errors[error]) {
              $("#Input" + $rootScope.capitalize(error))
                .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
            }
          }
        });
    };

    scope.actionForm = scope.guardarAlerta;

    if ($state.params.alerta_id != undefined) {
      scope.actionForm = scope.actualizarAlerta;
      $http.get('/alerts/' + $state.params.alerta_id + '.json')
      .success(function(data){
        scope.alertForm = data.alert;
        $rootScope.prolibertas = "Editar Alerta"
      });
    }
    else {
      scope.actionForm = scope.guardarAlerta;
      $rootScope.prolibertas = "Crear Alerta"
    }

  }]);


})();
