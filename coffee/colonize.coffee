# Singleton
define [
  'lib/js-yaml'
  'lib/jquery'
  'widgets/debug_log'
  'collections/game_data_node'
  'game_objects/game_object'
], (
  yaml
  $
  DebugLog
  GameDataNode
  GameObject
) ->
  # TODO: Maybe we can use RequireJS more effectively here to make this smaller.
  class Colonize
    instance = null

    @get: ->
      instance ?= new ColonizeInstance()

    class ColonizeInstance
      constructor: ->

      init: ->
        DebugLog.init()

        $.ajax
          url: 'data/data.yml'
          async: false
          success: (data) =>
            console.log(data)
            @gameData = new GameDataNode(yaml.safeLoad(data))

        @root = new GameObject()

        @gameData.get('game_objects').each (node) =>
          @root.components.get('children').add new GameObject(node)

        @lastTick = 0

      onFrame: (event) =>
        @onTick(event) if (event.time - @lastTick) >= 0.05

        @onFrameCallbacks.execute(event)

      onTick: (event) ->
        @lastTick = event.time

        @onTickCallbacks.execute()

      findService: (filters) ->
        new ServiceFinder(this).findProvider filters
  Colonize.get()
