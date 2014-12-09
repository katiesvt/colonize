# TODO: Make this more efficient.
define [
  'require'
  'components/behaviour_component'
  'components/building_behaviour_component'
  'components/building_renderer_component'
  'components/data_store_component'
  'components/game_object_pool_component'
  'components/pool_component'
  'components/renderer_component'
], (
  require
) ->
  class ComponentLoader
    @create: (underscoredName, parent) ->
      throw new Error("ComponentLoader called with empty string") unless underscoredName?
      componentModule = require(@_getComponentPath(underscoredName))
      new componentModule(parent)

    @_getComponentPath: (classname) ->
      "components/#{classname.replace(/([^_])([A-Z])/g, "$1_$2").toLowerCase()}"
