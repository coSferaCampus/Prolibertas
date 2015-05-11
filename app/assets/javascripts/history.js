(function(){
  var app = angular.module('prolibertas-history', ['ui.router', 'angularFileUpload']);

  app.controller('HistoriesController', ['$http', '$state', '$timeout', function($http, $state, $timeout){
    var scope = this;
    scope.histories = [];

    scope.alertaCreado = $state.params.alertaCreado;
    // La alerta se oculta después de 5 segundos
    $timeout(function(){scope.alertaCreado = false;}, 5000);

    scope.alertaBorrado = $state.params.alertaBorrado;
    // La alerta se oculta después de 5 segundos
    $timeout(function(){scope.alertaBorrado = false;}, 5000);

    $http.get('/people/'+ $state.params.id + '/histories.json')
      .success(function(data){
        scope.histories = data.histories;
      })
  }]);

  app.controller('HistoryController', ['$http', '$state', function($http, $state){
    var scope = this;
    scope.history = [];

    $http.get('/histories/' + $state.params.historia_id + '.json')
      .success(function(data){
        scope.history = data.history;
      })

    scope.destroyHistory = function(history) {
      var confirmed = confirm('¿Desea borrar la historia?');
      if (confirmed) {
        $http.delete('/histories/' + history.id + '.json').success(function(data) {
          $state.go("persona.historias", { alertaBorrado: 'true' })
        });
      }
    };
  }]);

  app.controller('HistoryFormController', ['$http', '$state', '$rootScope','$upload', function($http, $state, $rootScope, $upload) {
    var scope = this;
    // variable para el formulario
    scope.historyForm = {};
   //variable para los errores
    scope.errors = {};


    $('.datepicker').datetimepicker({locale: 'es', format: 'L'});
    $('.datetimepicker').datetimepicker({locale: 'es', format: 'HH:mm'});

    scope.change = function(field) {
      if(scope.errors[field.toLowerCase()]) {
        $("#Input" + field).tooltip('destroy');
        scope.errors[field.toLowerCase()] = false
      }
    };

    scope.formDates = function(){
      scope.historyForm.date = $('#InputDate').val();
      scope.historyForm.time = $('#InputTime').val();
      scope.historyForm.newdate = $('#InputDatenew').val();
      scope.historyForm.newtime = $('#InputTimenew').val();
    };

    scope.guardarHistoria = function() {
      scope.formDates();
      $upload.upload({
        url: "/people/" + $state.params.id + "/histories.json",
        method: "POST",
        fields: scope.historyForm,
        file: scope.historyForm.file,
        fileFormDataName: "history[file]",
        formDataAppender: function(fd, key, val){
          fd.append('history[' + key + ']', val || '');
        }
      })
      .success(function(data){
          $state.go('persona.historias', { alertaCreado: 'true' });
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

    scope.actualizarHistoria = function() {
      scope.formDates();
      //$http.put("/histories/" + $state.params.historia_id + ".json",{history: scope.historyForm})
      $upload.upload({
        url: "/histories/" + $state.params.historia_id + ".json",
        method: "PUT",
        fields: scope.historyForm,
        file: scope.historyForm.file,
        fileFormDataName: "history[file]",
        formDataAppender: function(fd, key, val){
          fd.append('history[' + key + ']', val || '');
        }
      })
        .success(function() {
          $state.go("persona.historia", {id: $state.params.id, historia_id: $state.params.historia_id});
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

    scope.actionForm = scope.guardarHistoria;

    if ($state.params.historia_id != undefined) {
      scope.actionForm = scope.actualizarHistoria;
      $http.get('/histories/' + $state.params.historia_id + '.json')
      .success(function(data){
        console.log(data.history);
        scope.historyForm = data.history;
        $rootScope.prolibertas = "Editar Historia"
      });
    }
    else {
      scope.actionForm = scope.guardarHistoria;
      $rootScope.prolibertas = "Historia nueva"
    }
  }]);
})();