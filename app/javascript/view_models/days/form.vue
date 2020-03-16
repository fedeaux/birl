<template lang="pug">
.entity-form-wrapper.days-form-wrapper.default-container(v-if='day')
  .entity-form.days-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='day.name')

      .field
        label Stamp
        input(type='text' v-model='day.stamp')

      .field
        label Meta

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import DaysResource from '../../resources/days_resource'
import Day from '../../models/day'

export default
  model:
    prop: 'original_day'

  props:
    original_day: null

  data: ->
    day: null

  methods:
    save: ->
      @$emit 'input', @day
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_day:
      immediate: true
      deep: true
      handler: ->
        if @original_day
          @day = @original_day.clone()
        else
          @day = null
</script>
