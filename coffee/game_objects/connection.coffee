define ['lib/paper', 'game_objects/game_object'], (paper, GameObject) ->
  class Connection extends GameObject
    layerTable:
      road:
        color: '#999'
        falloffStart: 100
        maxSpan: 300
      power:
        color: '#ffe700'
        falloffStart: 300
        maxSpan: 600
      wood:
        color: '#009900'
        falloffStart: 100
        maxSpan: 300

    constructor: (@colonize, @provider, @consumer, @type) ->
      console.log("creating connection from #{@provider.type} to #{@consumer.type} with type #{@type}")
      @strokeOffset = 0
      @render()

    getLength: ->
      @consumer.getPosition().subtract(@provider.getPosition()).length

    getEfficiency: ->
      # TODO: Make this calculation non-linear.
      return 1 if @getLength() < @_getFalloffStart()
      return 0 if @getLength() > @_getMaxSpan()

      Math.round(1 - ((@getLength() - @_getFalloffStart()) / @_getMaxSpan()))

    connectsTo: (location) ->
      @provider.equals(location) || @consumer.equals(location)

    # TODO: Rename this function.
    sharesRoadWith: (connection) ->
      (@provider.equals(connection.provider) ||
      @provider.equals(connection.consumer)) &&
      (@consumer.equals(connection.provider) ||
      @consumer.equals(connection.consumer))

    _getStrokeColor: ->
      Connection::layerTable[@type].color

    _getFalloffStart: ->
      Connection::layerTable[@type].falloffStart

    _getMaxSpan: ->
      Connection::layerTable[@type].maxSpan

    render: ->
      @line?.remove()
      @text?.remove()

      leftPosition = @provider.getPosition()
      rightPosition = @consumer.getPosition()

      offset = rightPosition.subtract(leftPosition)
      if @strokeOffset
        perpendicular = offset.normalize()
        perpendicular.angle -= 90
        perpendicular.length = @strokeOffset

      lineFrom = new paper.Point(
        length: 35
        angle: offset.angle
      ).add(leftPosition.add(perpendicular))

      lineTo = new paper.Point(
        length: 35
        angle: offset.angle + 180
      ).add(rightPosition.add(perpendicular))

      @middlePoint = lineTo.subtract(lineFrom).divide(2).add(lineFrom)

      @text = new paper.PointText
        point: @middlePoint
        #content: @getEfficiency() + "%"
        content: @strokeOffset
        fillColor: 'black'
        fontFamily: 'Helvetica Neue'
        fontWeight: 200
        fontSize: 14
        justification: 'center'

      @line = new paper.Path.Line
        from: lineFrom
        to: lineTo
        strokeColor: @_getStrokeColor()
        strokeWidth: 3
