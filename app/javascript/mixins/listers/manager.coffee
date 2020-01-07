import ListersResource from '../../resources/listers_resource'
import Lister from '../../models/lister'

export default
  props:
    context:
      default: -> {}

    parent_listers: null

  data: ->
    listers: null
    form_lister: null
    add_new: 'before'

  methods:
    listerAdded: (index, lister) ->
      # console.log 'listerAdded', index, lister

    getLister: (lister_id) ->
      index = @listerIndex lister_id
      return null if index == -1
      @listers[index]

    editLister: (data) ->
      @setFormLister data.lister

    destroyLister: (data) ->
      @listers_resource.destroy data.lister, @listerRemoved

    loadListers: ->
      @listers_resource ?= new ListersResource

      if @parent_listers
        @listersLoaded listers: @parent_listers
        return

      @listers_resource.index @listersLoaded, @context

    listersLoaded: (response) ->
      @listers = response.listers

    buildLister: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Lister final_params

    newLister: (params = {}) ->
      @setFormLister @buildLister params

    setFormLister: (@form_lister) ->
      @form_lister

    clearFormLister: ->
      @setFormLister null

    listerIndex: (lister_id) ->
      for index, lister of @listers
        return index if lister.id == lister_id

      -1

    saveLister: (lister, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @listerSaved(data)
          custom_callback(data)

        @listers_resource.save lister, callback
        return

      @listers_resource.save lister, @listerSaved

    saveFormLister: (custom_callback = false) ->
      @saveLister @form_lister, custom_callback

    createLister: (attributes, custom_callback = false) ->
      @saveLister @buildLister(attributes), custom_callback

    addLister: (lister) ->
      index = @listerIndex lister.id

      if index == -1
        if @add_new == 'before'
          @listers.unshift lister
          index = 0
        else
          @listers.push lister
          index = @listers.length - 1

      else
        Vue.set @listers, index, lister

      @listerAdded index, lister

    listerSaved: (data) ->
      @addLister data.lister
      @clearFormLister()

    listerRemoved: (data) ->
      index = @listerIndex data.lister.id
      return if index == -1
      @listers.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadListers()
