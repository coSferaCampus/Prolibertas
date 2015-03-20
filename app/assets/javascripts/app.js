(function() {
  var app = angular.module('prolibertas', ['ui.router', 'templates', 'prolibertas-person']);

  // Config
  app.config(function($urlRouterProvider, $stateProvider, $httpProvider) {
  	// Para las urls que no se encuentren, redirigimos a la raíz.
 	 $urlRouterProvider.otherwise("/personas");
  	// Aquí establecemos los estados de nuestra applicación.
	  $stateProvider
	  .state("personas", {
	    url: "/personas?alerta",
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
    });
  });

  app.run(function($rootScope, $state) {
    // Para usar $state en las vistas
    $rootScope.$state = $state;

    // Comprueba si un objeto está vacío
    $rootScope.capitalize = function(string) {
      return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    };
  });
})();