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
    $provide.factory "globalErrorMessage", ($q, growl) ->
      responseError: (rejection) ->
        growl.error(rejection.data.errors) if rejection.data
        $q.reject rejection

    growlProvider.globalTimeToLive(5000);
    $httpProvider.interceptors.push "globalErrorMessage"

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'RecipesController'
      ).when('/recipes/new',
        templateUrl: "form.html"
        controller: 'RecipeController'
      ).when('/recipes/:recipeId',
         templateUrl: "show.html"
         controller: 'RecipeController'
      ).when('/recipes/:recipeId/edit',
        templateUrl: "form.html"
        controller: 'RecipeController'
      ).when('/tables',
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
      )
])

controllers = angular.module('controllers',[])
services = angular.module('services', [])
directives = angular.module('directives', [])