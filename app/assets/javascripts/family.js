(function() {
  var app = angular.module('prolibertas-family', ['ui.router']);

  // Controllers
  app.controller('FamiliesController', ['$http','$timeout','$rootScope', '$state', function($http, $timeout, $rootScope, $state) {
     var scope = this;
     scope.families = [];
     scope.familyForm = {};
     scope.errors = {};

     scope.alertaCreado = $state.params.alertaCreado;

     // La alerta se oculta después de 5 segundos
     $timeout(function() { scope.alertaCreado = false; }, 5000);

     scope.alertaBorrado = $state.params.alertaBorrado;
     // La alerta se oculta después de 5 segundos
     $timeout(function() { scope.alertaBorrado = false; }, 5000);
     $rootScope.prolibertas = "Lista de Familias";

    $http.get('/families.json')
      .success(function(data) {
        scope.families = data.families;
      });
    scope.change = function( field ) {
      if( scope.errors[ field.toLowerCase() ] ) {
        $( "#Input" + field ).tooltip( 'destroy' );
        scope.errors[ field.toLowerCase() ] = false
      }
    };

    scope.guardarFamilia = function() {
      $http.post('/families.json', { family: scope.familyForm })
        .success(function(data){
          $state.go('familias', { alertaCreado: 'true' });
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

    scope.actualizarFamilia = function() {
      $http.put( "/families/" + $state.params.id + ".json",{ family: scope.familyForm } )
        .success(function() {
          $state.go( "familia", { id: $state.params.id } );
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

    scope.actionForm = scope.guardarFamilia;

    if ($state.params.id != undefined) {

      scope.actionForm = scope.actualizarFamilia;

      $rootScope.prolibertas = "Editar Familia";

      $http.get('/families/' + $state.params.id + '.json')
        .success( function(data ) {
          scope.familyForm = data.family;
      });
    }
    else {
        scope.actionForm = scope.guardarFamilia;
      $rootScope.prolibertas = "Crear Familia";
    }

  }]);

  app.controller('FamilyController',  ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope ) {
    var scope = this;
    scope.family = {};

    $http.get('/families/' + $state.params.id + '.json')
    .success(function(data){
      scope.family = data.family;
      $rootScope.prolibertas = scope.family.name + ' ' + scope.family.surname
    });

    scope.destroyFamily = function( family ) {
      var confirmed = confirm('¿Desea borrar a ' + family.name + ' ' + family.surname + '?');
      if ( confirmed ) {
        $http.delete('/families/' + family.id + '.json').success( function( data ) {
          $state.go( "familias", { alertaBorrado: 'true' } )
        });
      }
    };

    scope.genero = function( genero ) {
      if ( genero == "man" ) {
        return 'H';
      }
      else if ( genero == "woman" ) {
        return 'M';
      }
    };

    scope.asistencia = function(value) {
      if (value === 0) { return 'Primera vez'; }
      else if(value === 1) { return 'Habitual'; }
      else if(value === 2) { return 'Reincidente'; }
    };

  }]);
})();
