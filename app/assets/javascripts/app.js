(function() {

  var app = angular.module('prolibertas', ['ui.router', 'templates', 'prolibertas-person', 'prolibertas-history', 'prolibertas-user', 'prolibertas-article', 'prolibertas-alert', 'prolibertas-service', 'prolibertas-family']);

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

    .state("usuariosNuevo", {
      url: "/usuarios/nuevo",
      templateUrl: "usuarios-nuevo.html",
      controller: "UserFormController",
      controllerAs: "userFormCtrl"
      })

    .state("usuario", {
      url: "/usuarios/:id",
      templateUrl: "usuario.html",
      controller: "UserController",
      controllerAs: "userCtrl"
    })

    .state("usuarioEditar", {
      url: "/usuarios/:id/editar",
      templateUrl: "usuarios-nuevo.html",
      controller: "UserFormController",
      controllerAs: "userFormCtrl"
    })

    .state("usuario.perfil", {
      url: "/perfil",
      templateUrl: "perfil.html",
      controller: "UserFormController",
      controllerAs: "userFormCtrl"
    })

    .state("personas", {
      url: "/personas?alertaCreado&alertaBorrado&alertaGuardado",
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

    .state("persona.informe", {
      url: "/informe",
      views:{
        menupersona:{
          templateUrl: "persona-informe.html",
          controller: "PersonReportController",
          controllerAs: "personCtrl"
        }
      }
    })

    .state("persona.alertas", {
      url: "/alertas?alertaCreado&alertaBorrado",
      views:{
        menupersona:{
          templateUrl: "alertas.html",
          controller: "AlertsController",
          controllerAs: "alertsCtrl"
        }
      },
    })

    .state("persona.adjuntos", {
      url: "/adjuntos",
      views:{
        menupersona:{
          templateUrl: "adjuntos.html",
          controller: "PersonFilesController",
          controllerAs: "filesCtrl"
        }
      },
    })

    .state("persona.alertasNueva", {
      url: "/alertas/nueva",
      views:{
        menupersona:{
        templateUrl: "alerta-nueva.html",
        controller: "AlertFormController",
        controllerAs: "alertCtrl"
        }
      }
    })

    .state("persona.alerta", {
      url: "/alertas/:alerta_id",
      views:{
        menupersona:{
          templateUrl: "alerta.html",
          controller: "AlertController",
          controllerAs: "alertCtrl"
        }
      }
    })

    .state("persona.alertaEditar", {
      url: "/alertas/:alerta_id/editar",
      views:{
        menupersona:{
          templateUrl: "alerta-nueva.html",
          controller: "AlertFormController",
          controllerAs: "alertCtrl"
        }
      }
    })

    .state("persona.historias", {
       url: "/historias?alertaCreado&alertaBorrado",
       views:{
         menupersona:{
           templateUrl: "historias.html",
           controller: "HistoriesController",
           controllerAs: "historiesCtrl"
         }
        }
      })

     .state("persona.historiaNueva", {
        url: "/historias/nueva",
        views:{
         menupersona:{
            templateUrl: "form_historia.html",
            controller: "HistoryFormController",
            controllerAs: "historyFormCtrl"
         }
        }
      })

    .state("persona.historia", {
        url: "/historias/:historia_id",
        views:{
          menupersona:{
            templateUrl: "historia.html",
            controller: "HistoryController",
            controllerAs: "historyCtrl"
          }
        }
      })

     .state("persona.historiaEditar", {
        url: "/historias/:historia_id/editar",
        views:{
          menupersona:{
            templateUrl: "form_historia.html",
            controller: "HistoryFormController",
            controllerAs: "historyFormCtrl"
          }
        }
      })

     .state("persona.articulos", {
      url: "/articulos?alertaCreado&alertaBorrado",
      views:{
        menupersona:{
          templateUrl: "articulos.html",
          controller: "ArticlesController",
          controllerAs: "articlesCtrl"
        }
      },
    })

    .state("persona.articulosNuevo", {
      url: "/articulos/nuevo",
      views:{
        menupersona:{
        templateUrl: "articulo-nuevo.html",
        controller: "ArticleFormController",
        controllerAs: "articleCtrl"
        }
      }
    })

    .state("persona.articulo", {
      url: "/articulos/:articulo_id",
      views:{
        menupersona:{
          templateUrl: "articulo.html",
          controller: "ArticleController",
          controllerAs: "articleCtrl"
        }
      }
    })

    .state("persona.articuloEditar", {
      url: "/articulos/:articulo_id/editar",
      views:{
        menupersona:{
          templateUrl: "articulo-nuevo.html",
          controller: "ArticleFormController",
          controllerAs: "articleCtrl"
        }
      }
    })

     .state("servicios", {
      url: "/servicios?alertaCreado&alertaBorrado",
      templateUrl: "services.html",
      controller: "ServicesController",
      controllerAs: "servicesCtrl"
     })

      .state("familias", {
       url: "/familias?alertaCreado&alertaBorrado",
       templateUrl:  "familias.html",
       controller:   "FamiliesController",
       controllerAs: "familyCtrl"
     })

    .state("familia", {
      url: "/familias/:id",
      templateUrl: "familia.html",
       controller: "FamilyController",
       controllerAs: "familyCtrl"
    })

    .state("familiaEditar", {
      url: "/familias/:id/editar",
      templateUrl: "familia-nueva.html",
       controller: "FamiliesController",
       controllerAs: "familyCtrl"
    })

     .state("familiasNueva", {
       url: "/familias/nueva",
       templateUrl: "familia-nueva.html",
       controller: "FamiliesController",
       controllerAs: "familyCtrl"
    })

     .state("informes", {
      url: "/informes",
      templateUrl: "informes.html"
     });
  });

  //Filtros
  app.filter("filteri18n",["$filter",function($filter) {
    var filterFn=$filter("filter");

    /** Transforma el texto quitando todos los acentos diéresis, etc. **/
    function normalize(texto) {
        texto = texto.replace(/[áàäâ]/g, "a");
        texto = texto.replace(/[éèëê]/g, "e");
        texto = texto.replace(/[íìïî]/g, "i");
        texto = texto.replace(/[óòôö]/g, "o");
        texto = texto.replace(/[úùüü]/g, "u");
        texto = texto.toUpperCase();
        return texto;
    }

    /** Esta función es el comparator en el filter **/
    function comparator(actual, expected) {
      if (actual && expected) {
        if (normalize(actual).indexOf(normalize(expected))>=0) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    }

    /** Este es realmente el filtro **/
    function filteri18n(array,expression) {
      //Lo único que hace es llamar al filter original pero pasado
      //la nueva función de comparator
      return filterFn(array,expression,comparator)
    }

    return filteri18n;
  }]);

  // Funciones globales
  app.run(function($rootScope, $state, $http) {
    // Capitalizar palabra
    $rootScope.capitalize = function(string) {
      return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    };

    // Imprimir Web
    $rootScope.printDocument = function() {
      window.print();
    };

    // Obtener el usuario logeado
    $rootScope.currentUser = {};
    $http.get('/current.json').success(function(data) { $rootScope.currentUser = data.user; });

  });
})();
