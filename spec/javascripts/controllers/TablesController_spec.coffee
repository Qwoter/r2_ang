describe "TablesController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  # access injected service later
  httpBackend  = null

  setupController = (results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams

      # capture the injected service
      httpBackend = $httpBackend
      request = new RegExp("\/tables")
      httpBackend.expectGET(request).respond(results)

      ctrl = $controller('TablesController',
                         $scope: scope
                         $location: location)
    )

  beforeEach(module("r2_ang"))
  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'showing no tables', ->
      beforeEach(setupController())

      it 'defaults to no tables', ->
        expect(scope.tables).toEqualData([])
        httpBackend.flush()

    describe 'showing some tables', ->
      tables = [
        {
          id: 1
          number: '1'
        },
        {
          id: 2
          number: '2'
        }
      ]
      beforeEach ->
        setupController(tables)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.tables).toEqualData(tables)