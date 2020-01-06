import MemesResource from '../../resources/memes_resource'
import Meme from '../../models/meme'

export default
  props:
    context:
      default: -> {}

    parent_memes: null

  data: ->
    memes: null
    form_meme: null

  methods:
    memeAdded: (index, meme) ->
      # console.log 'memeAdded', index, meme

    getMeme: (meme_id) ->
      index = @memeIndex meme_id
      return null if index == -1
      @memes[index]

    editMeme: (data) ->
      @setFormMeme data.meme

    destroyMeme: (data) ->
      @memes_resource.destroy data.meme, @memeRemoved

    loadMemes: ->
      @memes_resource.index @memesLoaded, @context

    memesLoaded: (response) ->
      @memes = response.memes

    newMeme: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormMeme new Meme final_params

    setFormMeme: (@form_meme) ->
      @form_meme

    clearFormMeme: ->
      @setFormMeme null

    memeIndex: (meme_id) ->
      for index, meme of @memes
        return index if meme.id == meme_id

      -1

    saveFormMeme: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @memeSaved(data)
          custom_callback(data)

        @memes_resource.save @form_meme, callback
        return

      @memes_resource.save @form_meme, @memeSaved

    addMeme: (meme) ->
      index = @memeIndex meme.id

      if index == -1
        @memes.unshift meme
        index = 0

      else
        Vue.set @memes, index, meme

      @memeAdded index, meme

    memeSaved: (data) ->
      @addMeme data.meme
      @clearFormMeme()

    memeRemoved: (data) ->
      index = @memeIndex data.meme.id
      return if index == -1
      @memes.splice index, 1

  mounted: ->
    @memes_resource = new MemesResource

    if @parent_memes
      @memes = @parent_memes
      return

    unless @context
      @loadMemes()

  watch:
    context:
      immediate: true
      handler: ->
        @memes_resource ?= new MemesResource
        @loadMemes()
