<template lang="pug">
.entity-form-wrapper.timelogs-form-wrapper.default-container(v-if='timelog')
  .entity-form.timelogs-form
    .ui.form
      .field
        label Description
        input(type='text' v-model='timelog.description')

      .field
        label Meta

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import TimelogsResource from '../../resources/timelogs_resource'
import Timelog from '../../models/timelog'

export default
  model:
    prop: 'original_timelog'

  props:
    original_timelog: null

  data: ->
    timelog: null

  methods:
    save: ->
      @$emit 'input', @timelog
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_timelog:
      immediate: true
      deep: true
      handler: ->
        if @original_timelog
          @timelog = @original_timelog.clone()
        else
          @timelog = null
</script>
