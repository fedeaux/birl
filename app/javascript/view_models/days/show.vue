<template lang="pug">
.days-show-wrapper.flex-column.t-padded-2(v-if='day')
  .days-show.flex-item-fixed
    days-display(:day='day')
      shared-link.action-text(:to='day.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import DaysResource from '../../resources/days_resource'

export default
  props:
    parent_day: null
    day_id:
      default: null

  data: ->
    day: null

  methods:
    loadDay: ->
      return unless @day_id
      @days_resource.get @day_id, @dayLoaded

    dayLoaded: (response) ->
      @day = response.day

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @day = @parent_day if @parent_day
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    day_id:
      immediate: true
      handler: ->
        @days_resource ?= new DaysResource
        @loadDay()
</script>
