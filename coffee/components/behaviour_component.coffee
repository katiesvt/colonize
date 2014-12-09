define ['components/component'], (Component) ->
  class BehaviourComponent extends Component
    implements: ->
      'behaviour'

    # Shortcut to get data from a particular key on the data component of the GameObject.
    getData: (key) ->
      @component('data').get(key)

    # Shortcut to set data on a particular key on the data component of the GameObject.
    setData: (key, value) ->
      @component('data').set(key, value)
