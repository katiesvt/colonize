define ['lib/underscore', 'collections/key_value_store'], (_, KeyValueStore) ->
  class GameDataNode
    constructor: (@_data) ->

    get: (string) ->
      nodes = string.split('.')
      @_autoWrap(@_recursiveTraversal(@_data, nodes))

    each: (func) ->
      _.each @_data, (elem) =>
        func(@_autoWrap(elem))

    _autoWrap: (anything) ->
      console.log anything
      if _.isString(anything)
        console.log "it's a string!!"
        anything
      else if _.isUndefined(anything)
        undefined
      else
        console.log("autowrap node = #{anything}")
        new GameDataNode(anything)

    _recursiveTraversal: (currentNode, arrayToTraverse) =>
      return currentNode unless arrayToTraverse.length > 0
      currentNode = currentNode[arrayToTraverse.shift()]
      @_recursiveTraversal currentNode, arrayToTraverse
