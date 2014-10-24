controllers = angular.module('controllers')
controllers.controller("RecipeController", [ '$scope', '$routeParams', '$resource', '$location',
  ($scope,$routeParams,$resource,$location)->
    Recipe = $resource('/recipes/:recipeId', { recipeId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.recipeId
      Recipe.get({recipeId: $routeParams.recipeId},
        ( (recipe)-> $scope.recipe = recipe ),
        ( (httpResponse)->
          $scope.recipe = null
        )
      )
    else
      $scope.recipe = {}

    $scope.back   = -> $location.path("/")
    $scope.edit   = -> $location.path("/recipes/#{$scope.recipe.id}/edit")
    $scope.cancel = ->
      if $scope.recipe.id
        $location.path("/recipes/#{$scope.recipe.id}")
      else
        $location.path("/")

    $scope.save = ->
      if $scope.recipe.id
        $scope.recipe.$save(
          ( ()-> $location.path("/recipes/#{$scope.recipe.id}") ))
      else
        Recipe.create($scope.recipe,
          ( (newRecipe)-> $location.path("/recipes/#{newRecipe.id}") )
        )

    $scope.delete = ->
      $scope.recipe.$delete()
      $scope.back()
])