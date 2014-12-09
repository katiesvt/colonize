define [
  'lib/underscore'
  'collections/callback_queue'
  'services/module'
], (_, CallbackQueue, Module) ->
  keyValueStoreModule =
    # structure
    # key:
    #   value: <value>
    #   default: <default>
    #   onSet: CallbackQueue

    constructor: (defaults) ->
      @_data = {}

      _.each(defaults, (value, key) =>
        @_getNodeFor(key).default = value
      ) if defaults?

      console.log(@_data)

    get: (property) ->
      if node = @_getNodeFor property
        # TODO: Re-evaluate this logic when I wake up.
        node.value || node.default
      else
        throw new Error(
          "Couldn't retrieve property `#{property}` or suitable default"
        )

    set: (property, value) ->
      node = @_getNodeFor(property)
      node.value = value
      node.onSet.execute(value)

    onSet: (property, callback) ->
      @_getNodeFor(property).onSet.add callback

    has: (property) ->
      _.has @_data, property
    pick: (keys...) ->
      _.pick @_data, keys
    omit: (keys...) ->
      _.omit @_data, keys
    extend: (properties) ->
      _.extend @_data, properties

    sum: (keys...) ->
      res = 0
      for key in keys
        res += @get(key)
      res

    addTo: (dest, keys...) ->
      @set dest, @sum(dest, keys)

    each: (func) ->
      return if @_data.length == 0
      _.each @_data, func

    _getNodeFor: (property) ->
      @_data[property] ?= {onSet: new CallbackQueue()}

  class KeyValueStore extends Module
    @include keyValueStoreModule

    @module: keyValueStoreModule
