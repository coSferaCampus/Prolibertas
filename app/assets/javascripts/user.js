(function(){
  var app = angular.module('prolibertas-user', ['ui.router']);

  // Controllers
  app.controller('UsersController', ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope){
    var scope = this;
    scope.users = [];

    scope.alertaBorrado = $state.params.alertaBorrado;
    // La alerta se oculta después de 5 segundos
    $timeout(function(){scope.alertaBorrado = false;}, 5000);

    scope.alertaCreado = $state.params.alertaCreado;
    // La alerta se oculta después de 5 segundos
    $timeout(function(){scope.alertaCreado = false;}, 5000);

    $http.get('/users.json')
      .success(function(data){
        scope.users = data.users;
      })
    
    scope.rol = function(rol) {
      if (rol == "worker") {
        return 'Trabajador Social';
      }
      else if (rol == "director") {
        return 'Director';
      }
      else {
        return 'Voluntario';
      }
    };

  }]);

  app.controller('UserController',  ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope ) {
    var scope = this;
    scope.user = {};

    $http.get('/users/' + $state.params.id + '.json')
    .success(function(data){
      scope.user = data.user;
      $rootScope.prolibertas = scope.user.name + ' ' + scope.user.surname
    });

    scope.rol = function(rol) {
      if (rol == "worker") {
        return 'Trabajador Social';
      }
      else if (rol == "director") {
        return 'Director';
      }
      else {
        return 'Voluntario';
      }
    };

    scope.destroyuser = function(user) {
      var confirmed = confirm('¿Desea borrar a ' + user.name + '?');
      if (confirmed) {
        $http.delete('/users/' + user.id + '.json').success(function(data) {
          $state.go("usuarios", { alertaBorrado: 'true' })
        }); 
      }
    };
  }]);

  app.controller('UserFormController', ['$http', '$state', '$rootScope',function($http, $state, $rootScope) {
    var scope = this;
    // variable para el formulario
    scope.userForm = {};

    scope.guardarUsuario = function() {
      $http.post('/users.json', {user: scope.userForm})
        .success(function(data){
          $state.go('usuarios', { alertaCreado: 'true' });
        })
    };

  }]);
})();