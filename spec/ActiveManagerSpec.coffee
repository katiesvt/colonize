describe 'ActiveManager', ->
  describe 'new ActiveManager', ->
    beforeEach ->
      @parent = {testValue: 4}
      @data = [
        {key: 'value'}
      ]
      @am = new ActiveManager(@parent, @data)
    it 'assigns @parent', ->
      expect(@am.parent.testValue).toBe 4
    it 'assigns data', ->
      expect(@am._data[0].key).toBe 'value'

  describe '.add', ->
    beforeEach ->
      @elem = {key: 'value'}
      @am = new ActiveManager()
    it 'increases count()', ->
      currentCount = @am.count()
      @am.add(@elem)
      expect(@am.count()).toBe currentCount + 1
    it 'adds the element to @_data', ->
      @am.add(@elem)
      expect(@am._data[0].key).toBe 'value'

  describe '.any', ->
    beforeEach ->
      @am = new ActiveManager(undefined, [
          key: 'value1'
        ,
          key: 'value2'
      ])
    describe 'with object matcher', ->
      it 'returns true when a match exists', ->
        expect(@am.any(key: 'value1')).toBe true
        expect(@am.any(key: 'value2')).toBe true
      it 'returns false when nothing matches', ->
        expect(@am.any(key: 'value3')).toBe false
    describe 'with function matcher', ->
      it 'returns true when a match exists', ->
        expect(@am.any((elem) ->
          elem.key == 'value1'
        )).toBe true
      it 'returns false when a match does not exist', ->
        expect(@am.any((elem) ->
          elem.key == 'value3'
        )).toBe false

  describe '.each', ->
    beforeEach ->
      @am = new ActiveManager(undefined, [
          key: 'value1'
        ,
          key: 'value2'
      ])
    it 'executes once for each item', ->
      executionCount = 0

      @am.each (item) ->
        executionCount += 1

      expect(executionCount).toBe 2
    it 'passes the element as a parameter', ->
      @am.each (item) ->
        expect(item).toBeDefined()
        expect(item.key == 'value1' || item.key == 'value2').toBe true
    it 'does nothing if there are no items', ->
      @am = new ActiveManager()
      executionCount = 0

      @am.each (item) ->
        # should not run this
        executionCount += 1

      expect(executionCount).toBe 0
