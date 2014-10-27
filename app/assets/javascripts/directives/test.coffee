angular.module('directives').directive('test', () ->
  link: (scope,element) ->
    console.log  123, angular.element(element).css("color")
    angular.element(element).css("color","red")
    console.log angular.element(element).css("color")
)