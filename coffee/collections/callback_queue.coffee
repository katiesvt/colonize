define ['lib/underscore'], (_) ->
  class CallbackQueue
    constructor: ->
      @_queue = []

    add: (func) ->
      @_queue.push func

    execute: (params...) =>
      @_queue = _.filter @_queue, (callback) ->
        callback.apply(undefined, params)
