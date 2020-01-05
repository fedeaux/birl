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
               v-model='selected_tag_id')

</template>

<script lang="coffee">
import TagsManagerMixin from '../../mixins/tags/manager'

export default
  mixins: [TagsManagerMixin]

  model:
    prop: 'tag_id'

  props:
    tag_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_tag_id: null

  methods:
    tagAdded: (index, tag) ->
      @selectTag tag

    selectTag: (tag) ->
      @selected_tag_id = parseInt tag.id

  computed:
    loading: ->
      !@tags

    tags_as_options: ->
      return [] unless @tags
      { key: tag.id, value: tag.id, text: tag.name } for tag in @tags

  watch:
    selected_tag_id: ->
      selected_tag_id = parseInt @selected_tag_id

      unless isNaN selected_tag_id
        @$emit 'input', selected_tag_id
        return

      @newTag name: @selected_tag_id

    tag_id:
      immediate: true
      handler: ->
        return unless @tag_id
        @selected_tag_id = parseInt @tag_id

</script>
