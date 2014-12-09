define ['components/pool_component'], (PoolComponent) ->
  class GameObjectPoolComponent extends PoolComponent
    constructor: ->
      super

    onTick: =>
      @each (gameObject) ->
        gameObject.onTick()

    onFrame: =>
      @each (gameObject) ->
        gameObject.onFrame()

    implements: ->
      "children"
