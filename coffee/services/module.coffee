define [], () ->
  moduleKeywords = ['extended', 'included']

  class Module
    @extend: (obj) ->
      for key, value of obj when key not in moduleKeywords
        console.log("adding #{key}, #{value} to #{obj} static")
        @[key] = value

      obj.extended?.apply(@)
      this

    @include: (obj) ->
      for key, value of obj when key not in moduleKeywords
        console.log("adding #{key}, #{value} to #{obj} prototype")
        @::[key] = value

      obj.included?.apply(@)
      this
