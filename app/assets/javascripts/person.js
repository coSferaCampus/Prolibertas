(function(){
  var app = angular.module('prolibertas-person', ['ui.router']);

  app.controller('PeopleController', ['$http', function($http){
    var scope = this;
    scope.people = [];

    $http.get('/people.json')
      .success(function(data){
        scope.people = data.people;
      })
  }])

})();