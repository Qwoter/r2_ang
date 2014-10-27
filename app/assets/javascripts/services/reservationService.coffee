services = angular.module('services')
services.factory("reservationService", ['$resource',
  ($resource) ->
    setup: () ->
      $resource('/reservations/:reservationId', { reservationId: "@id", format: 'json' },
        {
          'save':   {method:'PUT'},
          'create': {method:'POST'}
        }
      )

    getAll: () ->
      $resource('/reservations', { format: 'json' }).query()
])