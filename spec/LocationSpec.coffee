describe 'Location', ->
  beforeEach ->
    spyOn(paper, 'view').and.returnValue {
      center: new paper.Point([500, 500])
    }

  describe '.constructor', ->
    xit 'does not throw', ->
      expect(->
        new Location([0, 0], 'test', {})
      ).not.toThrow()
