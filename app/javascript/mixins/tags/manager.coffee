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
    add_new: 'before'

  methods:
    tagAdded: (index, tag) ->
      # console.log 'tagAdded', index, tag

    getTag: (tag_id) ->
      index = @tagIndex tag_id
      return null if index == -1
      @tags[index]

    editTag: (data) ->
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

    buildTag: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      params.background_color ?= {}
      params.color ?= {}

      for key, value of params
        final_params[key] = value

      new Tag final_params

    newTag: (params = {}) ->
      @setFormTag @buildTag params

    setFormTag: (@form_tag) ->
      @form_tag

    clearFormTag: ->
      @setFormTag null

    tagIndex: (tag_id) ->
      for index, tag of @tags
        return index if tag.id == tag_id

      -1

    saveTag: (tag, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @tagSaved(data)
          custom_callback(data)

        @tags_resource.save tag, callback
        return

      @tags_resource.save tag, @tagSaved

    saveFormTag: (custom_callback = false) ->
      @saveTag @form_tag, custom_callback

    createTag: (attributes, custom_callback = false) ->
      @saveTag @buildTag(attributes), custom_callback

    addTag: (tag) ->
      index = @tagIndex tag.id

      if index == -1
        if @add_new == 'before'
          @tags.unshift tag
          index = 0
        else
          @tags.push tag
          index = @tags.length - 1

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
