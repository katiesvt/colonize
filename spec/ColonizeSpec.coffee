describe 'Colonize', ->
  describe '.get', ->
    it 'returns a value', ->
      expect(colonize).toBeDefined()
    xit 'returns a ColonizeInstance'
  describe '.init', ->
    beforeEach ->
      spyOn(DebugLog, 'get').and.returnValue true
      spyOn(DebugLog, 'log').and.returnValue true

    it 'does not throw', ->
      expect(->
        colonize.init()
      ).not.toThrow()

  describe '.onFrame', ->
    beforeEach ->
      spyOn(DebugLog, 'get').and.returnValue true
      spyOn(DebugLog, 'log').and.returnValue true
      colonize.lastTick = 0
      spyOn colonize, 'onTick'
      spyOn(paper, 'view').and.returnValue {
        center: new paper.Point([500, 500])
      }

    xit 'does not throw', ->
      expect(->
        colonize.onFrame({time: 0})
      ).not.toThrow()

    xit 'ticks when @lastTick is over 0.05s ago', ->
      colonize.onFrame({time: 5})
      expect(colonize.onTick).toHaveBeenCalled()

    xit 'does not tick when @lastTick is less than 0.05s ago', ->
      colonize.onFrame({time: 0.02})
      expect(colonize.onTick).not.toHaveBeenCalled()

  xdescribe '.onTick', ->
  xdescribe '.createLocation', ->
  xdescribe '.connectLocations', ->
