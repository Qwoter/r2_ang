services = angular.module('services')
services.factory("tableService", ['$resource',
  ($resource) ->
    getCRUD: () ->
      $resource('/tables/:tableId', { tableId: "@id", format: 'json' },
        {
          'save':   {method:'PUT'},
          'create': {method:'POST'}
        }
      )

    getAll: () ->
      $resource('/tables/:tableId', { tableId: "@id", format: 'json' })
])