r2_ang = angular.module('r2_ang',[
  'templates',
  'ngRoute',
  'controllers',
  'ngResource',
  'directives',
  'angular-growl',
  'ngAnimate',
  'services',
  'ui.bootstrap'
])

r2_ang.config([ '$routeProvider', '$provide', '$httpProvider', 'growlProvider',
  ($routeProvider,$provide,$httpProvider,growlProvider)->
    growlProvider.globalTimeToLive(5000);
    $httpProvider.interceptors.push "globalErrorMessage"

    $routeProvider
      .when('/',
        templateUrl: "tables/index.html"
        controller: 'TablesController'
      ).when('/tables/new',
        templateUrl: "tables/form.html"
        controller: 'TableController'
      ).when('/tables/:tableId',
         templateUrl: "tables/show.html"
         controller: 'TableController'
      ).when('/tables/:tableId/edit',
        templateUrl: "tables/form.html"
        controller: 'TableController'
      ).when('/reservations',
        templateUrl: "reservations/index.html"
        controller: 'ReservationsController'
      ).when('/reservations/new',
        templateUrl: "reservations/form.html"
        controller: 'ReservationController'
      ).when('/reservations/:reservationId',
         templateUrl: "reservations/show.html"
         controller: 'ReservationController'
      ).when('/reservations/:reservationId/edit',
        templateUrl: "reservations/form.html"
        controller: 'ReservationController'
      ).when('/timeline',
        templateUrl: "timeline.html"
        controller: 'TimelineController'

      )
])

controllers = angular.module('controllers',[])
services = angular.module('services', [])
directives = angular.module('directives', [])