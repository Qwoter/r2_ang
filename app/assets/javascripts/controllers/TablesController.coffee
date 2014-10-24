controllers = angular.module('controllers')
controllers.controller("TablesController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    Table = $resource('/tables/:tableId', { tableId: "@id", format: 'json' })

    $scope.tables = Table.query()
    $scope.view = (tableId)-> $location.path("/tables/#{tableId}")
    $scope.newTable = -> $location.path("/tables/new")
    $scope.edit      = (tableId)-> $location.path("/tables/#{tableId}/edit")
])

controllers.controller("TableController", [ '$scope', '$routeParams', '$resource', '$location',
  ($scope,$routeParams,$resource,$location)->
    Table = $resource('/tables/:tableId', { tableId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

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
        $scope.table.number = _httpResponse.data.number if _httpResponse.data

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
])