<template lang="pug">
.entity-new.day-new.default-container
  .entity-display
    .entity-display-main New Day

  days-form(v-model='day'
            @save='saveDay'
            @cancel='back')
</template>

<script lang="coffee">

import DaysResource from '../../resources/days_resource'
import Day from '../../models/day'

export default
  data: ->
    day: new Day

  methods:
    saveDay: ->
      @days_resource.save @day, @saved

    saved: (data) ->
      @$router.push data.day.path()

    back: ->
      @$router.push @day.collectionPath()

  mounted: ->
    @days_resource = new DaysResource
</script>
