class Player
  constructor: (@config) ->
    @audios = {}
    @events = {}
    @images = {}
    @schema = null

    for schema, config of @config.schemas
      @audios[schema] ||= {}
      @events[schema] ||= {}
      @images[schema] = config.image

      for event, audios of config.events
        @events[schema][event] = []

        for audio in audios
          name = @namelize audio
          @audios[schema][name] = new Audio(audio)
          @events[schema][event].push name

  schemas: ->
    Object.keys @audios

  setSchema: (@schema) ->

  availableEvents: (schema) ->
    schema ?= @schema
    return unless schema && @events[schema]

    Object.keys @events[schema]

  availableAudios: (schema) ->
    schema ?= @schema
    return unless schema && @audios[schema]

    Object.keys @audios[schema]

  play: (name, schema) ->
    schema ?= @schema
    return unless schema && @audios[schema] && @audios[schema][name]

    @audios[schema][name].play()

  image: (schema) ->
    @images[schema]

  event: (event, schema) ->
    schema ?= @schema

    return unless schema && @events[schema] && @events[schema][event]
    n = @events[schema][event].length
    return if n < 1

    i = Math.floor Math.random() * n
    @play @events[schema][event][i], schema

  namelize: (path) ->
    parts = path.split('/')
    return parts[parts.length - 1].split('.')[1].split('-')[0]

export default Player
