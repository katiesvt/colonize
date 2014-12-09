define ['lib/paper'], (paper) ->
  class ProgressCircle
    constructor: (@origin, options) ->
      {@angleOffset, @radius, @strokeColor, @strokeWidth, @value} = options if options?

      @angleOffset ?= -90
      @radius      ?= 35
      @strokeColor ?= 'black'
      @strokeWidth ?= 2
      @value       ?= 0

      @_render() if @value > 0

    setValue: (@value) -> @_render()
    getValue: -> @value

    remove: ->
      @arc?.remove()

    _render: ->
      @arc?.remove()

      destAngle = (@value / 100 * 360)

      @arc = new paper.Path.Arc
        from: new paper.Point(
          length: @radius
          angle: @angleOffset
        ).add @origin
        through: new paper.Point(
          length: @radius
          angle: (destAngle / 2) + @angleOffset
        ).add @origin
        to: new paper.Point(
          length: @radius
          angle: (destAngle) + @angleOffset
        ).add @origin
        strokeColor: @strokeColor
        strokeWidth: @strokeWidth
