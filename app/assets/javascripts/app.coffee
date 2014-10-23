r2_ang = angular.module('r2_ang',[
  'templates',
  'ngRoute',
  'controllers',
  'ngResource',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

r2_ang.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

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
      )
])

controllers = angular.module('controllers',[])
