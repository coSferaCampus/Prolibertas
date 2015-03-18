(function(){
  var app = angular.module('prolibertas-person-form', ['ui.router']);

  app.controller('PeopleController', ['$http', function($http){
    var scope = this;
    scope.newPerson = [];


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

  }])

})();