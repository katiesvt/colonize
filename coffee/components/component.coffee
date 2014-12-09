define ['services/module'], (Module) ->
  class Component extends Module
    constructor: (@gameObject)->

    onInit: ->

    onTick: ->
    onClick: ->
    onFrame: ->

    implements: ->
      throw new Error("You must override the implements function for your components.")


    # Do not override these functions unless you know what you are doing

    # Finds a component on the parent GameObject that provides service.
    component: (service) ->
      @gameObject.components.get(service)
