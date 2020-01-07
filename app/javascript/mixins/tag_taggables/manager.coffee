import TagTaggablesResource from '../../resources/tag_taggables_resource'
import TagTaggable from '../../models/tag_taggable'

export default
  props:
    context:
      default: -> {}

    parent_tag_taggables: null

  data: ->
    tag_taggables: null
    form_tag_taggable: null

  methods:
    tagTaggableAdded: (index, tagTaggable) ->
      # console.log 'tagTaggableAdded', index, tagTaggable

    getTagTaggable: (tag_taggable_id) ->
      index = @tagTaggableIndex tagTaggable_id
      return null if index == -1
      @tag_taggables[index]

    editTagTaggable: (data) ->
      @setFormTagTaggable data.tag_taggable

    destroyTagTaggable: (data) ->
      @tag_taggables_resource.destroy data.tag_taggable, @tagTaggableRemoved

    loadTagTaggables: ->
      @tag_taggables_resource ?= new TagTaggablesResource

      if @parent_tag_taggables
        @tagTaggablesLoaded tag_taggables: @parent_tag_taggables
        return

      @tag_taggables_resource.index @tagTaggablesLoaded, @context

    tagTaggablesLoaded: (response) ->
      @tag_taggables = response.tag_taggables

    newTagTaggable: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormTagTaggable new TagTaggable final_params

    setFormTagTaggable: (@form_tag_taggable) ->
      @form_tag_taggable

    clearFormTagTaggable: ->
      @setFormTagTaggable null

    tagTaggableIndex: (tag_taggable_id) ->
      for index, tag_taggable of @tag_taggables
        return index if tag_taggable.id == tag_taggable_id

      -1

    saveFormTagTaggable: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @tagTaggableSaved(data)
          custom_callback(data)

        @tag_taggables_resource.save @form_tag_taggable, callback
        return

      @tag_taggables_resource.save @form_tag_taggable, @tagTaggableSaved

    addTagTaggable: (tag_taggable) ->
      index = @tagTaggableIndex tag_taggable.id

      if index == -1
        @tag_taggables.unshift tag_taggable
        index = 0

      else
        Vue.set @tag_taggables, index, tag_taggable

      @tagTaggableAdded index, tag_taggable

    tagTaggableSaved: (data) ->
      @addTagTaggable data.tag_taggable
      @clearFormTagTaggable()

    tagTaggableRemoved: (data) ->
      index = @tagTaggableIndex data.tag_taggable.id
      return if index == -1
      @tag_taggables.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadTagTaggables()
