controllers = angular.module('controllers')
controllers.controller("navCtrl", [ "$scope", "$location", ($scope, $location) ->
  $scope.navClass = (page) ->
    currentRoute = $location.path().substring(1) or "home"
    (if page is currentRoute then "active" else "")
])