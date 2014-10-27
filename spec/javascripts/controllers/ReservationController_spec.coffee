describe "ReservationController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  location     = null
  reservationId      = 42

  fakeReservation   =
    id: reservationId
    details: "Usual for Henry"

  setupController =(reservationExists=true,reservationId=42)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.reservationId = reservationId if reservationId

      if reservationId
        request = new RegExp("\/reservations/#{reservationId}")
        results = if reservationExists
          [200,fakeReservation]
        else
          [404]

        httpBackend.expectGET(request).respond(results[0],results[1])

      ctrl        = $controller('ReservationController',
                                $scope: scope)
    )

  beforeEach(module("r2_ang"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'reservation is found', ->
      beforeEach(setupController())
      it 'loads the given reservation', ->
        httpBackend.flush()
        expect(scope.reservation).toEqualData(fakeReservation)
    describe 'reservation is not found', ->
      beforeEach(setupController(false))
      it 'loads the given reservation', ->
        httpBackend.flush()
        expect(scope.reservation).toBe(null)

    describe 'create', ->
      newReservation =
        id: 42
        details: 'Usual for Henry'

      beforeEach ->
        setupController(false,false)
        request = new RegExp("\/reservations")
        httpBackend.expectPOST(request).respond(201,newReservation)

      it 'posts to the backend', ->
        scope.reservation.details = newReservation.details
        scope.save()
        httpBackend.flush()
        expect(location.path()).toBe("/reservations/#{newReservation.id}")

    describe 'update', ->
      updatedReservation =
        details: 'Anny with teaparty'

      beforeEach ->
        setupController()
        httpBackend.flush()
        request = new RegExp("\/reservations")
        httpBackend.expectPUT(request).respond(204)

      it 'posts to the backend', ->
        scope.reservation.details = updatedReservation.details
        scope.save()
        httpBackend.flush()
        expect(location.path()).toBe("/reservations/#{scope.reservation.id}")

    describe 'delete' ,->
      beforeEach ->
        setupController()
        httpBackend.flush()
        request = new RegExp("\/reservations/#{scope.reservation.id}")
        httpBackend.expectDELETE(request).respond(204)

      it 'posts to the backend', ->
        scope.delete()
        httpBackend.flush()
        expect(location.path()).toBe("/reservations")