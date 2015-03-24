(function() {
  var app = angular.module('prolibertas', ['ui.router', 'templates', 'prolibertas-person']);

  // Config
  app.config(function($urlRouterProvider, $stateProvider, $httpProvider) {
  	// Para las urls que no se encuentren, redirigimos a la raíz.
 	  $urlRouterProvider.otherwise("/personas");

  	// Aquí establecemos los estados de nuestra applicación.
    $stateProvider
    .state("usuarios", {
      url: "/usuarios?alertaCreado&alertaBorrado",
      templateUrl: "usuarios.html",
        controller: "UsersController",
        controllerAs: "usersCtrl"
       })

    .state("personas", {
      url: "/personas?alertaCreado&alertaBorrado",
      templateUrl: "personas.html",
        controller: "PeopleController",
        controllerAs: "peopleCtrl"
  	})

    .state("personasNueva", {
      url: "/personas/nueva",
      templateUrl: "persona-nueva.html",
        controller: "PersonFormController",
        controllerAs: "personCtrl"
    })

    .state("persona", {
      url: "/personas/:id",
      templateUrl: "persona.html",
        controller: "PersonController",
        controllerAs: "personCtrl"
    })

    .state("personaEditar", {
      url: "/personas/:id/editar",
      templateUrl: "persona-nueva.html",
        controller: "PersonFormController",
        controllerAs: "personCtrl"    
    })

    .state("persona.historias", {
      url: "/historias",
      views:{
        menupersona:{
          templateUrl: "historias.html" 
        }
      }
    })

    .state("persona.alertas", {
      url: "/alertas",
      views:{
        menupersona:{
        templateUrl: "alertas.html"
        }
      }
    })

    .state("alertasNueva", {
      url: "/personas/:id/alertas/nueva",
      templateUrl: "alerta-nueva.html"
    })

    .state("alerta", {
      url: "/personas/:id/alertas/alerta",
      templateUrl: "alerta.html",
    })

    .state("alertaEditar", {
      url: "/personas/:id/alertas/alerta/editar",
      templateUrl: "alerta-nueva.html",   
    });

    
  });

  app.run(function($rootScope, $state) {
    // Capitalizar palabra
    $rootScope.capitalize = function(string) {
      return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    };
  });
})();