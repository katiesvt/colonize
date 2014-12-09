requirejs.config
  shim:
    'lib/paper':
      exports: 'paper'
    'lib/underscore':
      exports: '_'
    'lib/jquery':
      exports: '$'
  paths:
    paper: 'lib/paper-full'

require ['colonize', 'lib/paper'], (Colonize, paper) ->
  canvas = document.getElementById 'c'
  paper.setup canvas

  Colonize.init()

  paper.view.onFrame = (event) ->
    Colonize.onFrame(event)
