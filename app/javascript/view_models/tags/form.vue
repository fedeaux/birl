<template lang="pug">
.entity-form-wrapper.tags-form-wrapper.default-container(v-if='tag')
  tags-tag(:tag='tag')

  .entity-form.tags-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='tag.name')

      .field
        label Color
        color-picker(v-model='tag.color')

      .field
        label Background Color
        color-picker(v-model='tag.background_color')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import TagsResource from '../../resources/tags_resource'
import Tag from '../../models/tag'

export default
  model:
    prop: 'original_tag'

  props:
    original_tag: null

  data: ->
    tag: null

  methods:
    save: ->
      @$emit 'input', @tag
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_tag:
      immediate: true
      deep: true
      handler: ->
        if @original_tag
          @tag = @original_tag.clone()
        else
          @tag = null
</script>
