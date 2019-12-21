<template lang="pug">
.entity-form-wrapper.contexts-form-wrapper.default-container(v-if='context')
  .entity-form.contexts-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='context.name')

      .field
        label Slug
        input(type='text' v-model='context.slug')

      .field
        label Color
        input(type='text' v-model='context.color')

      .field
        label Meta

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import ContextsResource from '../../resources/contexts_resource'
import Context from '../../models/context'

export default
  model:
    prop: 'original_context'

  props:
    original_context: null

  data: ->
    context: null

  methods:
    save: ->
      @$emit 'input', @context
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_context:
      immediate: true
      deep: true
      handler: ->
        if @original_context
          @context = @original_context.clone()
        else
          @context = null
</script>
