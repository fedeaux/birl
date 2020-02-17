<template lang="pug">
  shared-modal(v-if='form_tag' title='New Tag')
    tags-form(v-model='form_tag'
                   @save='saveFormTag()'
                   @cancel='clearFormTag()')

  sui-dropdown(:options='tags_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Tag'
               v-else
               v-model='selected_tag')
</template>

<script lang="coffee">
import TagsManagerMixin from '../../mixins/tags/manager'

export default
  mixins: [TagsManagerMixin]

  model:
    prop: 'tag'

  props:
    tag:
      default: null

    allow_additions:
      default: true

    emit:
      default: 'id'

  data: ->
    selected_tag: null
    selected_tag_id: null

  methods:
    tagAdded: (index, tag) ->
      @selected_tag = tag

  computed:
    loading: ->
      !@tags

    tags_as_options: ->
      return [] unless @tags

      { key: tag.id, value: tag, text: tag.name } for tag in @tags

  watch:
    selected_tag: ->
      @selected_tag_id = @selected_tag.id

      unless isNaN @selected_tag_id
        @$emit 'input', (@emit == 'id' and @selected_tag_id or @selected_tag)
        return

      @newTag name: @selected_tag_id

    tag:
      immediate: true
      handler: ->
        return unless @tag

        if typeof @tag == 'Object'
          @selected_tag_id = parseInt @tag.id
          @selected_tag = @tag
        else
          @selected_tag_id = parseInt @tag

</script>
