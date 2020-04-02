<template lang="pug">
.entity-form-wrapper.weeks-form-wrapper.default-container(v-if='week')
  .entity-form.weeks-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='week.name')

      .field
        label Stamp
        input(type='text' v-model='week.stamp')

      .field
        label Meta

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import WeeksResource from '../../resources/weeks_resource'
import Week from '../../models/week'

export default
  model:
    prop: 'original_week'

  props:
    original_week: null

  data: ->
    week: null

  methods:
    save: ->
      @$emit 'input', @week
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_week:
      immediate: true
      deep: true
      handler: ->
        if @original_week
          @week = @original_week.clone()
        else
          @week = null
</script>
