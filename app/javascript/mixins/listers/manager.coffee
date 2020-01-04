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
      @listers_resource.index @listersLoaded, @context

    listersLoaded: (response) ->
      @listers = response.listers

    newLister: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormLister new Lister final_params

    setFormLister: (@form_lister) ->
      @form_lister

    clearFormLister: ->
      @setFormLister null

    listerIndex: (lister_id) ->
      for index, lister of @listers
        return index if lister.id == lister_id

      -1

    saveFormLister: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @listerSaved(data)
          custom_callback(data)

        @listers_resource.save @form_lister, callback
        return

      @listers_resource.save @form_lister, @listerSaved

    addLister: (lister) ->
      index = @listerIndex lister.id

      if index == -1
        @listers.unshift lister
        index = 0

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

  mounted: ->
    @listers_resource = new ListersResource

    if @parent_listers
      @listers = @parent_listers
      return

    unless @context
      @loadListers()

  watch:
    context:
      immediate: true
      handler: ->
        @listers_resource ?= new ListersResource
        @loadListers()
