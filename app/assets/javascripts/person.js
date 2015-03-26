(function(){
  var app = angular.module('prolibertas-person', ['ui.router']);

  // Controllers
  app.controller('PeopleController', ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope){
    var scope = this;
    scope.people = [];
    scope.alertaCreado = $state.params.alertaCreado;

    // La alerta se oculta después de 5 segundos
    $timeout(function(){scope.alertaCreado = false;}, 5000);

    scope.alertaBorrado = $state.params.alertaBorrado;
    // La alerta se oculta después de 5 segundos
    $timeout(function(){scope.alertaBorrado = false;}, 5000);
    $rootScope.prolibertas = "Lista de Personas"

    $http.get('/people.json')
      .success(function(data){
        scope.people = data.people;
      })

    scope.genero = function(genero){
      if (genero == "man") {
        return 'H';
      }
      else {
        return 'M';
      }
    }
  }]);

  app.controller('PersonController',  ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope ) {
    var scope = this;
    scope.person = {};


    $http.get('/people/' + $state.params.id + '.json')
    .success(function(data){
      scope.person = data.person;
      $rootScope.prolibertas = scope.person.name + ' ' + scope.person.surname
    });

    scope.genero = function(genero){
      if (genero == "man") {
        return 'Hombre';
      }
      else {
        return 'Mujer';
      }
    };

    scope.destroyPerson = function(person) {
      var confirmed = confirm('¿Desea borrar a ' + person.name + ' ' + person.surname + '?');
      if (confirmed) {
        $http.delete('/people/' + person.id + '.json').success(function(data) {
          $state.go("personas", { alertaBorrado: 'true' })
        }); 
      }
    };

  }]);

  app.controller('PersonFormController', ['$http', '$state', '$rootScope',function($http, $state, $rootScope) {
    var scope = this;
    // variable para el formulario
    scope.personForm = {};
   //variable para los errores
    scope.errors = {};


    $('.datepicker').datepicker({
      format: "dd/mm/yyyy",
      startView: 2,
      clearBtn: true,
      language: "es",
      orientation: "top auto",
      autoclose: true
    });



    scope.change = function(field) {
      if(scope.errors[field.toLowerCase()]) {
        $("#Input" + field).tooltip('destroy');
        scope.errors[field.toLowerCase()] = false
      }
    };


    scope.guardarPersona = function() {
      $http.post('/people.json', {person: scope.personForm})
        .success(function(data){
          $state.go('personas', { alertaCreado: 'true' });
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

    scope.actualizarPersona = function() {
      $http.put("/people/" + $state.params.id + ".json",{person: scope.personForm})
        .success(function() {
          $state.go("persona", {id: $state.params.id});
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

    scope.actionForm = scope.guardarPersona;

    if ($state.params.id != undefined) {
      scope.actionForm = scope.actualizarPersona;
      $http.get('/people/' + $state.params.id + '.json')
      .success(function(data){
        scope.personForm = data.person;
        $rootScope.prolibertas = "Editar Persona"
      });
    }
    else {
      scope.actionForm = scope.guardarPersona;
      $rootScope.prolibertas = "Crear Persona"
    }

  }]);
})();