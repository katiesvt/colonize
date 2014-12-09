define [
  'lib/paper',
  'widgets/progress_circle',
  'components/renderer_component'
], (paper, ProgressCircle, RendererComponent) ->
  class LocationRendererComponent extends RendererComponent
    constructor: (@parent) ->

    onInit: ->
      # TODO: rewrite this
      @parent.properties.onSet 'buildProgress', @onUpdateBuildProgress
      @parent.properties.onSet 'state', @onUpdateState

      # TODO: This is a hack.
      @onUpdateState(0)

    onUpdateState: (@state) =>
      # 0 = building
      # 1 = finding resources
      # 2 = operational
      # 3 = disabled
      console.log("updating state to #{@state}")

      @_clear()

      switch @state
        when 0 then @_renderBuild()
        when 1 then @_renderSupply()
        when 2 then @_renderRun()
        when 3 then throw new Error("unsupported state 3")
      true

    onFrame: (event) =>
      # TODO: Refactor this into a base class and a render queue.
      @animation() if @animation
      true

    pulse: (options) ->
      {length, color} = options if options?

      length ?= 20
      color ?= 'black'

      animatedCircle = new paper.Shape.Circle
        center: @parent.getPosition()
        radius: 35
        strokeColor: color
        strokeWidth: 4

      # TODO: Put this into its own function to avoid performance bottleneck...
      @animation = =>
        length -= 1

        animatedCircle.radius += 1
        animatedCircle.opacity -= 0.05

        if length == 0
          @animation = null
          animatedCircle.remove()

    onUpdateBuildProgress: (newValue) =>
      @buildProgress.setValue newValue
      true

    _clear: ->
      console.log("cleared")
      @text?.remove()

      @buildProgress?.remove()

      @border?.remove()
      @background?.remove()
      @efficiencyCircle?.remove()
      @group?.remove()

    _renderBuild: ->
      @_createText()
      @_createBuildProgress()

    _renderSupply: ->
      @pulse()
      @_createText()
      @_createUI()
      #@_createSupplyProgress()

    _renderRun: ->
      @_createText()
      @_createUI()
      @_createRunningUI()

    _createText: ->
      console.log("creating text at #{@parent.getPosition().add([0, 3.5])}")
      @text = new paper.PointText
        point: @parent.getPosition().add([0, 3.5])
        content: @parent.type
        fillColor: 'black'
        fontFamily: 'Helvetica Neue'
        fontWeight: 200
        fontSize: 14
        justification: 'center'

    _createBuildProgress: ->
      @buildProgress = new ProgressCircle(@parent.getPosition())

    _createUI: ->
      @border = new paper.Shape.Circle
        center: @parent.getPosition()
        radius: 35
        strokeColor: 'black'
        strokeWidth: 4
      @background = new paper.Shape.Circle
        center: @parent.getPosition()
        radius: 35
        fillColor: 'white'
        opacity: 0.4

      @efficiencyCircle = new ProgressCircle @parent.getPosition(),
        radius: 32
        strokeColor: 'red'
        value: 77

      @group = new paper.Group [
        @background, @border, @text
      ]

      # TODO: Proper event system sometime soon?
      @group.onClick = @parent.onClick
