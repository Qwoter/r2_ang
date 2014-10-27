controllers = angular.module('controllers')
controllers.controller("ReservationsController", [ '$scope', '$routeParams', '$location', 'reservationService',
  ($scope,$routeParams,$location,reservationService)->
    $scope.reservations = reservationService.getAll()
    $scope.view = (reservationId)-> $location.path("/reservations/#{reservationId}")
    $scope.newReservation = -> $location.path("/reservations/new")
    $scope.edit      = (reservationId)-> $location.path("/reservations/#{reservationId}/edit")
])

controllers.controller("ReservationController", [ '$scope', '$routeParams', '$location', 'reservationService', 'tableService', '$filter','growl'
  ($scope,$routeParams,$location,reservationService,tableService,$filter,growl)->
    Reservation = reservationService.setup()
    $scope.tables = tableService.getAll()

    $scope.today = ->
      $scope.reservation = {}
      $scope.reservation.start_time = new Date()
      $scope.reservation.end_time = new Date()

    if $routeParams.reservationId
      Reservation.get({reservationId: $routeParams.reservationId},
        ( (reservation)-> $scope.reservation = reservation ),
        ( (httpResponse)-> $scope.reservation = {} )
      )
    else
      $scope.reservation = {}
      $scope.today()


    $scope.back   = -> $location.path("/reservations")
    $scope.edit   = -> $location.path("/reservations/#{$scope.reservation.id}/edit")
    $scope.cancel = ->
      if $scope.reservation.id
        $location.path("/reservations/#{$scope.reservation.id}")
      else
        $location.path("/reservations")

    $scope.save = ->
      # onError = (_httpResponse)->

      if $scope.reservation.id
        $scope.reservation.$save(
          ( ()-> 
              $location.path("/reservations/#{$scope.reservation.id}")
              growl.success("Successfully Saved") )
        )
      else
        Reservation.create($scope.reservation,
          ( (newReservation)-> 
              $location.path("/reservations/#{newReservation.id}")
              growl.success("Successfully Created") )
        )

    $scope.delete = ->
      $scope.reservation.$delete()
      $scope.back()

    $scope.disabled = (date, mode) ->
      mode is "day" and (date.getDay() is 0 or date.getDay() is 6)

    $scope.minDate = Date()
    $scope.format = "EEE MMM dd yyyy HH:mm:s Z"
    $scope.hstep = 1
    $scope.mstep = 5
    $scope.ismeridian = false

    $scope.open1 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened1 = true

    $scope.open2 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened2 = true

    $scope.changed = ->
      # $scope.reservation.start_time = Date.parse $scope.reservation.start_time
      console.log "Time changed to: " + $scope.mytime
  ] )