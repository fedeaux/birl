<template lang="pug">
.entity-edit.week-edit.default-container
  .entity-display
    .entity-display-main Edit Week

  weeks-form(v-model='week'
             v-if='week'
             @save='saveWeek()'
             @cancel='weekDone()')
</template>

<script lang="coffee">

import WeeksResource from '../../resources/weeks_resource'
import Week from '../../models/week'

export default
  props:
    week_id:
      default: null

  data: ->
    week: null

  methods:
    loadWeek: ->
      @weeks_resource.get @week_id, @weekLoaded

    weekLoaded: (response) ->
      @week = response.week

    saveWeek: ->
      @weeks_resource.save @week, @weekDone

    weekDone: ->
      @$router.push @week.path()

  mounted: ->
    @weeks_resource = new WeeksResource
    @loadWeek()
</script>
