export default class Device
  constructor: (@name) ->

  isMobile: ->
    @name == 'mobile'

  isDesktop: ->
    @name == 'desktop'

  homeComponentName: ->
    "#{@name}-home"
