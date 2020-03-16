<template lang="pug">
.entity-edit.day-edit.default-container
  .entity-display
    .entity-display-main Edit Day

  days-form(v-model='day'
            v-if='day'
            @save='saveDay()'
            @cancel='dayDone()')
</template>

<script lang="coffee">

import DaysResource from '../../resources/days_resource'
import Day from '../../models/day'

export default
  props:
    day_id:
      default: null

  data: ->
    day: null

  methods:
    loadDay: ->
      @days_resource.get @day_id, @dayLoaded

    dayLoaded: (response) ->
      @day = response.day

    saveDay: ->
      @days_resource.save @day, @dayDone

    dayDone: ->
      @$router.push @day.path()

  mounted: ->
    @days_resource = new DaysResource
    @loadDay()
</script>
