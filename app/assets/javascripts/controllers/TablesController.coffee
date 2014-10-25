controllers = angular.module('controllers')
controllers.controller("TablesController", [ '$scope', '$routeParams', '$location', 'tableService',
  ($scope,$routeParams,$location,tableService)->
    Table = tableService.getAll()

    $scope.tables = Table.query()
    $scope.view = (tableId)-> $location.path("/tables/#{tableId}")
    $scope.newTable = -> $location.path("/tables/new")
    $scope.edit      = (tableId)-> $location.path("/tables/#{tableId}/edit")
])

controllers.controller("TableController", [ '$scope', '$routeParams', '$location', 'tableService',
  ($scope,$routeParams,$location,tableService)->
    Table = tableService.getCRUD()

    if $routeParams.tableId
      Table.get({tableId: $routeParams.tableId},
        ( (table)-> $scope.table = table ),
        ( (httpResponse)->
          $scope.table = null
        )
      )
    else
      $scope.table = {}

    $scope.back   = -> $location.path("/tables")
    $scope.edit   = -> $location.path("/tables/#{$scope.table.id}/edit")
    $scope.cancel = ->
      if $scope.table.id
        $location.path("/tables/#{$scope.table.id}")
      else
        $location.path("/tables")

    $scope.save = ->
      onError = (_httpResponse)->
        $scope.table.number = _httpResponse.data.number if _httpResponse.dataa

      if $scope.table.id
        $scope.table.$save(
          ( ()-> $location.path("/tables/#{$scope.table.id}") ),
          onError)
      else
        Table.create($scope.table,
          ( (newTable)-> $location.path("/tables/#{newTable.id}") )
        )

    $scope.delete = ->
      $scope.table.$delete()
      $scope.back()

    $scope.dateModel = new Date()
    $scope.dateOptions =
      formatYear: "yy"
      startingDay: 1

    $scope.open = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true

    $scope.formats = [ "dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate" ]
    $scope.format = $scope.formats[0]
])