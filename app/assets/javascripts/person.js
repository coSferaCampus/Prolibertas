(function(){
  var app = angular.module('prolibertas-person', ['ui.router']);

  // Controllers
  app.controller('PeopleController', ['$http', '$timeout', '$state', function($http, $timeout, $state){
    var scope = this;
    scope.people = [];
    scope.alerta = $state.params.alerta;;
    // La alerta se oculta después de 3 segundos
    $timeout(function(){scope.alerta = false;}, 5000);

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

  app.controller('PersonController',  ['$http', '$state', function($http, $state) {
    var scope = this;
    scope.person = {};

    $http.get('/people/' + $state.params.id + '.json')
    .success(function(data){
      scope.person = data.person;
    });

    scope.destroyPerson = function(person) {
      var confirmed = confirm('¿Desea borrar a ' + person.name + ' ' + person.surname + '?');
      if (confirmed) {
        $http.delete('/people/' + person.id + '.json').success(function(data) {
          $state.go("personas")
        }); 
      }
    };

  }]);

  app.controller('PersonFormController', ['$http', '$state', function($http, $state){
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
          $state.go('personas', {alerta: 'true'});

        })
        .error(function(data) {
          scope.errors = data.errors;

          if(scope.errors.name) { 
            $("#InputName").tooltip({trigger: 'manual', title: scope.errors.name.join(', ')});    
            $("#InputName").tooltip('show');
          }
          if(scope.errors.surname) {
            $("#InputSurname").tooltip({trigger: 'manual', title: scope.errors.surname.join(', ')});    
            $("#InputSurname").tooltip('show');
          }
          if(scope.errors.genre) {
            $("#InputGenre").tooltip({trigger: 'manual', title: scope.errors.genre.join(', ')});    
            $("#InputGenre").tooltip('show');
          }
        });
    };

    scope.actualizarPersona = function() {
      $http.put("/people/" + $state.params.id + ".json",{person: scope.personForm})
        .success(function() {
          $state.go("persona", {id: $state.params.id});
          scope.errors = {};
        });
    };

    scope.actionForm = scope.guardarPersona;

    if ($state.params.id != undefined) {
      scope.actionForm = scope.actualizarPersona;
      $http.get('/people/' + $state.params.id + '.json')
      .success(function(data){
        scope.personForm = data.person;
      });
    }
    else{
      scope.actionForm = scope.guardarPersona;
    }

  }]);
})();