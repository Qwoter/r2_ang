describe "TableController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  location     = null
  tableId      = 42

  fakeTable   =
    id: tableId
    number: "1"

  setupController =(tableExists=true,tableId=42)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.tableId = tableId if tableId

      if tableId
        request = new RegExp("\/tables/#{tableId}")
        results = if tableExists
          [200,fakeTable]
        else
          [404]

        httpBackend.expectGET(request).respond(results[0],results[1])

      ctrl = $controller('TableController', $scope: scope)
    )

  beforeEach(module("r2_ang"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'table is found', ->
      beforeEach(setupController())
      it 'loads the given table', ->
        httpBackend.flush()
        expect(scope.table).toEqualData(fakeTable)

    describe 'table is not found', ->
      beforeEach(setupController(false))
      it 'loads the given table', ->
        httpBackend.flush()
        expect(scope.table).toBe(null)

    describe 'create', ->
      newTable =
        id: 42
        number: '1'

      beforeEach ->
        setupController(false,false)
        request = new RegExp("\/tables")
        httpBackend.expectPOST(request).respond(201,newTable)

      it 'posts to the backend', ->
        scope.table.number = newTable.number
        scope.save()
        httpBackend.flush()
        expect(location.path()).toBe("/tables/#{newTable.id}")

    describe 'update', ->
      updatedTable =
        number: '2'

      beforeEach ->
        setupController()
        httpBackend.flush()
        request = new RegExp("\/tables")
        httpBackend.expectPUT(request).respond(204)

      it 'posts to the backend', ->
        scope.table.number = updatedTable.number
        scope.save()
        httpBackend.flush()
        expect(location.path()).toBe("/tables/#{scope.table.id}")

    describe 'delete' ,->
      beforeEach ->
        setupController()
        httpBackend.flush()
        request = new RegExp("\/tables/#{scope.table.id}")
        httpBackend.expectDELETE(request).respond(204)

      it 'posts to the backend', ->
        scope.delete()
        httpBackend.flush()
        expect(location.path()).toBe("/")