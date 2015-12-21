(function() {
  var app = angular.module('prolibertas-article', ['ui.router']);

  app.controller('ArticlesController', ['$http', '$timeout', '$state', function($http, $timeout, $state) {
    var scope          = this;
    scope.articles     = [];
    scope.alertaCreado = $state.params.alertaCreado;

    // La alerta se oculta después de 5 segundos
    $timeout(function() { scope.alertaCreado = false; }, 1000);

    scope.alertaBorrado = $state.params.alertaBorrado;
    // La alerta se oculta después de 5 segundos
    $timeout(function() { scope.alertaBorrado = false; }, 1000);


    $http.get('/people/' + $state.params.id + '/articles.json').success(function(data) {
      scope.articles = data.articles;
    });

    scope.tipo = function(tipo) {
      if (tipo === "blanket") {
        return 'manta';
      } else if (tipo === "sheet") {
        return 'sábana';
      } else if (tipo === "jacket") {
        return 'chaqueta';
      } else if (tipo === "shoes") {
        return 'zapatos';
      } else if (tipo === "basket") {
        return 'canastillas';
      }
    }
  }]);

  app.controller('ArticleController', ['$http', '$state', function( $http, $state ) {
    var scope     = this;
    scope.article = [];

    $http.get('/articles/' + $state.params.articulo_id + '.json').success(function(data) {
      scope.article = data.article;
    });

    scope.tipo = function(tipo) {
      if (tipo === "blanket") {
        return 'manta';
      } else if (tipo === "sheet") {
        return 'sábana';
      } else if (tipo === "jacket") {
        return 'chaqueta';
      } else if (tipo === "shoes") {
        return 'zapatos';
      }
    };

    scope.destroyArticle = function(article) {
      var confirmed = confirm('¿Desea borrar el artículo?');
      if (confirmed) {
        $http.delete( '/articles/' + article.id + '.json' ).success(function(data) {
          $state.go("persona.articulos", { alertaBorrado: 'true' });
        });
      }
    };
  }]);

  app.controller( 'ArticleFormController', ['$http', '$filter', '$state', '$rootScope', function( $http, $filter, $state, $rootScope ) {
    var scope         = this;
    scope.articleForm = {};
    scope.errors      = {};

    // Fecha a día de hoy
    scope.articleForm.requested =  $filter('date')(new Date(), 'dd/MM/yyyy');

    // Fecha dentro de 30 días
    var dateIn30Days            = new Date(+new Date() + (86400000 * 30));
    scope.articleForm.dispensed = $filter('date')(dateIn30Days, 'dd/MM/yyyy');

    $('.datepicker').datetimepicker({locale: 'es', format: 'DD/MM/YYYY'});

    scope.change = function(field) {
      if(scope.errors[field.toLowerCase()]) {
        $("#Input" + field).tooltip('destroy');
        scope.errors[field.toLowerCase()] = false
      }
    };

    scope.formDates = function() {
      scope.articleForm.requested = $('#InputRequested').val();
      scope.articleForm.dispensed = $('#InputDispensed').val();
    };

    scope.guardarArticulo = function() {
      scope.formDates();
      $http.post('/people/' + $state.params.id + '/articles.json', { article: scope.articleForm })
        .success(function(data){
          $state.go('persona.articulos', { id: $state.params.id, alertaCreado: 'true' });
        })
        .error( function(data) {
          scope.errors = data.errors;

          for( var error in scope.errors ) {
            if(scope.errors[error]) {
              $( "#Input" + $rootScope.capitalize(error) )
                .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
            }
          }
        });
    };

    scope.actualizarArticulo= function() {
      scope.formDates();
      $http.put("/articles/" + $state.params.articulo_id + ".json",{ article: scope.articleForm })
        .success(function() {
          $state.go("persona.articulo", {articulo_id: $state.params.articulo_id});
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

    scope.actionForm = scope.guardarArticulo;

    if ( $state.params.articulo_id != undefined ) {
      scope.actionForm = scope.actualizarArticulo;
      $http.get('/articles/' + $state.params.articulo_id + '.json').success(function(data) {
        scope.articleForm      = data.article;
        $rootScope.prolibertas = "Editar Artículo"
      });
    }
    else {
      scope.actionForm       = scope.guardarArticulo;
      $rootScope.prolibertas = "Crear Artículo"
    }
  }]);

})();
