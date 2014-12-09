define [
  'components/component'
  'pools/pool'
], (Component, Pool) ->
  class PoolComponent extends Component
    @include Pool.module
