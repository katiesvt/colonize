define [
  'pools/component_pool'
  'collections/game_data_node'
], (ComponentPool, GameDataNode) ->
  class GameObject
    constructor: (dataNode) ->
      # We expect prototypes to already be resolved here.
      if dataNode?
        @components = new ComponentPool this, dataNode.get('components')
      else
        @components = new ComponentPool this, new GameDataNode
          children:
            provider: "GameObjectPoolComponent"
          data:
            provider: "DataStoreComponent"

        @components.initAll()

    onTick: ->
      @components.each (component) ->
        component.onTick?()
    onFrame: ->
      @components.each (component) ->
        component.onFrame?()
    onClick: ->
      @components.each (component) ->
        component.onClick?()
