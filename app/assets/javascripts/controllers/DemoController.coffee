controllers = angular.module('controllers')
controllers.controller("DateTimePickerDemoCtrl", [ "$scope", "$location",'$filter', '$timeout',
  ($scope,$location,$filter,$timeout) ->
    $scope.today = ->
      $scope.dt = Date.parse new Date()

    $scope.today()

    $scope.disabled = (date, mode) ->
      mode is "day" and (date.getDay() is 0 or date.getDay() is 6)

    $scope.minDate = Date()
    $scope.format = "shortDate"

    $scope.open = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true

    $scope.mytime = new Date()
    $scope.hstep = 1
    $scope.mstep = 15

    $scope.ismeridian = false
])