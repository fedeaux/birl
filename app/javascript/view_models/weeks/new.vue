<template lang="pug">
.entity-new.week-new.default-container
  .entity-display
    .entity-display-main New Week

  weeks-form(v-model='week'
             @save='saveWeek'
             @cancel='back')
</template>

<script lang="coffee">

import WeeksResource from '../../resources/weeks_resource'
import Week from '../../models/week'

export default
  data: ->
    week: new Week

  methods:
    saveWeek: ->
      @weeks_resource.save @week, @saved

    saved: (data) ->
      @$router.push data.week.path()

    back: ->
      @$router.push @week.collectionPath()

  mounted: ->
    @weeks_resource = new WeeksResource
</script>
