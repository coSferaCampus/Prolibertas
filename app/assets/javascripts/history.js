(function(){
  var app = angular.module('prolibertas-history', ['ui.router']);

  app.controller('HistoryController', ['$http', '$state', function($http, $state){
  var scope = this;
  scope.histories = [];

  $http.get('/people/'+ $state.params.id + '/histories.json')
    .success(function(data){
      scope.histories = data.histories;
    })

  }]);

})();