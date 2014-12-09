define [
  'game_objects/game_object'
  'components/building_renderer_component'
], (
  GameObject
  BuildingRendererComponent
) ->
  class Building extends GameObject
    constructor: (@properties) ->
      # node style:
      # location:
      #   location    -> KeyValueStore
      #   name        -> KeyValueStore
      #   description -> KeyValueStore
      #   resources   -> ResourceManager
      #   state       -> KeyValueStore

      @components.add new BuildingRendererComponent()

      # "complete" building based on state
      @_build()

    onClick: (event) =>
      @renderer.background.fillColor = 'f00'

    getPosition: ->
      # TODO: Calculate position from location logarithimically.
      new paper.Point(@location).multiply(2).add paper.view.center

    getAvailableOutput: (type) ->
      # TODO

    equals: (otherLocation) ->
      _.isEqual(this, otherLocation)

    _build: ->
      # TODO: modify base build speed based on material availability

      if @properties.get('buildProgress') >= 100 || @getState() == 1
        @_complete()

      # TODO: This should NOT reach into the Renderer class.
      @properties.addTo('buildProgress', 'buildSpeed')

    _complete: ->
      @setState 1
