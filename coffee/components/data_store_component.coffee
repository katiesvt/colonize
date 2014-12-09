define [
  'components/component'
  'collections/key_value_store'
], (Component, KeyValueStore) ->
  class DataStoreComponent extends Component
    @include KeyValueStore

    implements: ->
      'data'
