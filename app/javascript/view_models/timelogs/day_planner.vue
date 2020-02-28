<template lang="pug">
.day-planner.ui.form
  .fields
    .field
      .ui.primary.button(@click='planMyDay') Plan my day
    .field
      inputs-time(v-model='start')
</template>

<script lang="coffee">
import TimelogsResource from '../../resources/timelogs_resource'

export default
  props:
    base_date:
      default: -> moment()

  data: ->
    start: null

  methods:
    planMyDay: ->
      @timelogs_resource ?= new TimelogsResource
      @timelogs_resource.planMyDay @dayPlanned, start: @start.format()

    dayPlanned: ->
      @$emit 'dayPlanned'

  created: ->
    @start = @base_date.clone().hours(9).minutes(0)
</script>
