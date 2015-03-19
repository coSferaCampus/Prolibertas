(function(){
  var app = angular.module('prolibertas-person', ['ui.router']);

  // Controllers
  app.controller('PeopleController', ['$http', function($http){
    var scope = this;
    scope.people = [];

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
      console.log(scope.person);
    });

  }]);

})();