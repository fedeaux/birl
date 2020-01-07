<template lang="pug">
  shared-modal(v-if='form_tag_taggable' title='New Tag Taggable')
    tag-taggables-form(v-model='form_tag_taggable'
                   @save='saveFormTagTaggable()'
                   @cancel='clearFormTagTaggable()')

  sui-dropdown(:options='tag_taggables_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Tag Taggable'
               v-else
               v-model='selected_tag_taggable_id')

</template>

<script lang="coffee">
import TagTaggablesManagerMixin from '../../mixins/tag_taggables/manager'

export default
  mixins: [TagTaggablesManagerMixin]

  model:
    prop: 'tag_taggable_id'

  props:
    tag_taggable_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_tag_taggable_id: null

  methods:
    tagTaggableAdded: (index, tagTaggable) ->
      @selectTagTaggable tag_taggable

    selectTagTaggable: (tag_taggable) ->
      @selected_tag_taggable_id = parseInt tag_taggable.id

  computed:
    loading: ->
      !@tag_taggables

    tag_taggables_as_options: ->
      return [] unless @tag_taggables
      { key: tag_taggable.id, value: tag_taggable.id, text: tag_taggable.name } for tag_taggable in @tag_taggables

  watch:
    selected_tag_taggable_id: ->
      selected_tag_taggable_id = parseInt @selected_tag_taggable_id

      unless isNaN selected_tag_taggable_id
        @$emit 'input', selected_tag_taggable_id
        return

      @newTagTaggable name: @selected_tag_taggable_id

    tag_taggable_id:
      immediate: true
      handler: ->
        return unless @tag_taggable_id
        @selected_tag_taggable_id = parseInt @tag_taggable_id

</script>
