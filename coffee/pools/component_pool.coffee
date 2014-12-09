define ['require', 'pools/pool', 'services/component_loader'], (require, Pool, ComponentLoader) ->
  class ComponentPool extends Pool
    constructor: (@parent, dataNode) ->
      @_data = []

      dataNode.each (service) =>
        @add ComponentLoader.create(service.get('provider'), @parent)

    initAll: ->
      @each (component) ->
        component.onInit()

    # Gets the first component that provides given service.
    get: (service) ->
      @first (component) ->
        component.implements() == service
