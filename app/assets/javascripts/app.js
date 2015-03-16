(function() {
  var app = angular.module('prolibertas', ['ui.router', 'templates']);

  // Config
  app.config(function($urlRouterProvider, $stateProvider, $httpProvider) {
  	// Para las urls que no se encuentren, redirigimos a la raíz.
 	 $urlRouterProvider.otherwise("/personas");
  	// Aquí establecemos los estados de nuestra applicación.
	  $stateProvider
	  .state("personas", {
	    url: "/personas",
	    templateUrl: "personas.html"
  	});
  });
})();