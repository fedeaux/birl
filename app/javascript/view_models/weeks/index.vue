<template lang="pug">
weeks-manager.weeks-index(:parent_weeks='weeks')
</template>

<script lang="coffee">
import WeeksResource from '../../resources/weeks_resource'

export default
  data: ->
    weeks: null

  methods:
    loadWeeks: ->
      @weeks_resource.index @weeksLoaded

    weeksLoaded: (response) ->
      @weeks = response.weeks

  mounted: ->
    @weeks_resource = new WeeksResource
    @loadWeeks()
</script>
