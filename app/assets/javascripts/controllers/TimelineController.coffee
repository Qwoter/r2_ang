controllers = angular.module('controllers')
controllers.controller("TimelineController", [ "$scope", "$location", '$resource', '$routeParams',
  ($scope,$location,$resource,$routeParams) ->
    # Nice little emptiness checker
    empty = (mixed_var) ->
      undef = undefined
      key = undefined
      i = undefined
      len = undefined
      emptyValues = [ undef, null, false, 0, "", "0" ]
      i = 0
      len = emptyValues.length

      while i < len
        return true  if mixed_var is emptyValues[i]
        i++
      if typeof mixed_var is "object"
        for key of mixed_var
          return false
        return true
      false

    # Check for parameters
    if empty($routeParams.year) && empty($routeParams.month) && empty($routeParams.day)
      $scope.tables_reservations = $resource('/timeline', { format: 'json' }).query()
      $scope.today = new Date()
    else
      $scope.tables_reservations = $resource('/timeline', { format: 'json', day: $routeParams.day, month: $routeParams.month, year: $routeParams.year}).query()
      $scope.today = new Date($routeParams.year, $routeParams.month, $routeParams.day)

    $scope.nextDay = () ->
      # Only god knows why js can't next day normally
      tomorrow = new Date($scope.today)
      tomorrow.setDate(tomorrow.getDate() + 1)
      $location.search(day: tomorrow.getDate(), month: tomorrow.getMonth(), year: tomorrow.getFullYear());
      $scope.tables_reservations = $resource('/timeline', { format: 'json', day: tomorrow.getDate(), month: tomorrow.getMonth(), year: tomorrow.getFullYear()}).query()

    $scope.previousDay = () ->
      yesterday = new Date($scope.today)
      yesterday.setDate(yesterday.getDate() - 1)
      $location.search(day: yesterday.getDate(), month: yesterday.getMonth(), year: yesterday.getFullYear());
      $scope.tables_reservations = $resource('/timeline', { format: 'json', day: yesterday.getDate(), month: yesterday.getMonth(), year: yesterday.getFullYear()}).query()
])