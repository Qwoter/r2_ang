services = angular.module('services')
services.factory("globalErrorMessage", ['$q', 'growl',
  ($q, growl) ->
    responseError: (rejection) ->
      growl.error(rejection.data.errors) if rejection.data
      $q.reject rejection
])