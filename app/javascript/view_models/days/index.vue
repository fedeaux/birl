<template lang="pug">
days-manager.days-index(:parent_days='days')
</template>

<script lang="coffee">
import DaysResource from '../../resources/days_resource'

export default
  data: ->
    days: null

  methods:
    loadDays: ->
      @days_resource.index @daysLoaded

    daysLoaded: (response) ->
      @days = response.days

  mounted: ->
    @days_resource = new DaysResource
    @loadDays()
</script>
