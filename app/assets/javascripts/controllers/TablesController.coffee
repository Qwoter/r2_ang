controllers = angular.module('controllers')
controllers.controller("TablesController", [ '$scope', '$routeParams', '$location', 'tableService',
  ($scope,$routeParams,$location,tableService) ->
    $scope.tables = tableService.getAll()
    $scope.view = (tableId)-> $location.path("/tables/#{tableId}")
    $scope.newTable = -> $location.path("/tables/new")
    $scope.edit      = (tableId)-> $location.path("/tables/#{tableId}/edit")
])

controllers.controller("TableController", [ '$scope', '$routeParams', '$location', 'tableService', 'growl',
  ($scope,$routeParams,$location,tableService, growl) ->
    Table = tableService.setup()

    if $routeParams.tableId
      Table.get({tableId: $routeParams.tableId},
        ( (table)-> $scope.table = table ),
        ( (httpResponse)->
          $scope.table = null
        )
      )
    else
      $scope.table = {}

    $scope.back   = -> $location.path("/")
    $scope.edit   = -> $location.path("/tables/#{$scope.table.id}/edit")
    $scope.cancel = ->
      if $scope.table.id
        $location.path("/tables/#{$scope.table.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)->
        $scope.table.number = _httpResponse.data.number if _httpResponse.data

      if $scope.table.id
        $scope.table.$save(
          ( ()-> 
              $location.path("/tables/#{$scope.table.id}")
              growl.success("Successfully Saved") ),
          onError)
      else
        Table.create($scope.table,
          ( (newTable)->
              $location.path("/tables/#{newTable.id}")
              growl.success("Successfully Created") )
        )

    $scope.delete = ->
      $scope.table.$delete()
      $scope.back()
])