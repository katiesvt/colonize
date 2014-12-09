define ['lib/paper'], (paper) ->
  class DebugLog
    instance = null

    @init: ->
      @get()

    @get: ->
      instance ?= new DebugLogInstance(25)

    @log: (message) ->
      @get().log message

    class DebugLogInstance
      constructor: (@bufferSize) ->
        @buffer = ['Test Log Item']
        @labels = []

        @_createLabel(index) for index in [0...@bufferSize]
        @_render()

      log: (message) ->
        @buffer.shift() if @buffer.length >= @bufferSize
        @buffer.push(message)
        @_render()

      _render: ->
        for label, i in @labels
          label.content = @buffer[@buffer.length - (i + 1)] if @buffer.length > i

      _createLabel: (index) ->
        @labels.push new paper.PointText
          point: [0, (index + 1) * 16]
          content: ''
          fillColor: 'black'
          fontFamily: 'Helvetica Neue'
          fontWeight: 200
          fontSize: 14
