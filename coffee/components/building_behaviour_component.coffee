define ['components/behaviour_component'], (BehaviourComponent) ->
  class BuildingBehaviourComponent extends BehaviourComponent
    onTick: =>
      switch @getData('state')
        when 0 then @_build()
        when 1 then @_supply()
        when 2 then @_run()
