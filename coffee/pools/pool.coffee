define ['lib/underscore', 'services/module'], (_, Module) ->
  poolModule =
    constructor: (data) ->
      @_data = []

      if data?
        _.each data, (elem) =>
          @add elem

    # Adds an element to the end of the pool.
    add: (object) ->
      @_data.push object

    # Returns TRUE if any elements in the pool match the conditional.
    any: (conditional) ->
      !_.isUndefined @first(conditional)

    # Runs the given function on each element in the pool.
    each: (func) ->
      return if @_data.length == 0

      _.each @_data, func

    # Returns a new pool with only the elements matching the conditional.
    where: (conditional) ->
      if _.isFunction conditional
        @_wrap _.select @_data, conditional
      else if _.isObject conditional
        @_wrap _.where @_data, conditional
      else
        throw new Error("Couldn't use `where` on #{conditional}")

    # Returns the first element that matches the conditional.
    first: (conditional) ->
      if _.isFunction conditional
        _.detect @_data, conditional
      else if _.isObject conditional
        _.findWhere @_data, conditional
      else if _.isUndefined conditional
        @_data[0]
      else
        throw new Error("Couldn't use `first` on #{conditional}")

    # Returns the number of elements in the pool.
    count: ->
      @_data.length

    _wrap: (data) ->
      new Pool(data)

  class Pool extends Module
    @include poolModule

    @module: poolModule
