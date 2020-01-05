import TagsResource from '../../resources/tags_resource'
import Tag from '../../models/tag'

export default
  props:
    context:
      default: -> {}

    parent_tags: null

  data: ->
    tags: null
    form_tag: null

  methods:
    tagAdded: (index, tag) ->
      # console.log 'tagAdded', index, tag

    getTag: (tag_id) ->
      index = @tagIndex tag_id
      return null if index == -1
      @tags[index]

    editTag: (data, a) ->
      @setFormTag data.tag

    destroyTag: (data) ->
      @tags_resource.destroy data.tag, @tagRemoved

    loadTags: ->
      @tags_resource ?= new TagsResource

      if @parent_tags
        @tagsLoaded tags: @parent_tags
        return

      @tags_resource.index @tagsLoaded, @context

    tagsLoaded: (response) ->
      @tags = response.tags

    newTag: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormTag new Tag final_params

    setFormTag: (@form_tag) ->
      @form_tag

    clearFormTag: ->
      @setFormTag null

    tagIndex: (tag_id) ->
      for index, tag of @tags
        return index if tag.id == tag_id

      -1

    saveFormTag: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @tagSaved(data)
          custom_callback(data)

        @tags_resource.save @form_tag, callback
        return

      @tags_resource.save @form_tag, @tagSaved

    addTag: (tag) ->
      index = @tagIndex tag.id

      if index == -1
        @tags.unshift tag
        index = 0

      else
        Vue.set @tags, index, tag

      @tagAdded index, tag

    tagSaved: (data) ->
      @addTag data.tag
      @clearFormTag()

    tagRemoved: (data) ->
      index = @tagIndex data.tag.id
      return if index == -1
      @tags.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadTags()
