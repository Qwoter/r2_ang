angular.module('directives').directive('test', () ->
  link: (scope,element) ->
    angular.element(element).css("width","red")
)