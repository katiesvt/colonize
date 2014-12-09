define ['game/LocationManager'], (LocationManager) ->
  class ServiceFinder
    constructor: (@colonize) ->
    findProvider: (@filters) ->
      # ACCEPTABLE FILTERS
      # - type: where type is given value
      # - from: origin point to search
      # - maxDistance: farthest point to filter
      # - minAvailableCapacity: minimum available capacity
      # RETURNS LocationManager

      resultSet = new LocationManager()

      @colonize.locations.each (location) =>
        location.provides.where(type: @filters.type).where(@_filter).each (provider) =>
          resultSet.add provider

      resultSet

    _filter: (provider) =>
      # if @filters.minAvailableCapacity?
      #   return false if location.getAvailableOutput(@type) < @filters.minAvailableCapacity

      if @filters.from? and @filters.maxDistance?
        # TODO: implement this somehow.
        throw new Error("not implemented")

      true
