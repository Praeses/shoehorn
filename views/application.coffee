window.AppsCtrl = ($scope, $http) ->

  $http.get('/apps').success (data) ->
    $scope.apps = data
