<template lang="pug">
.weeks-show-wrapper.flex-column.t-padded-2(v-if='week')
  .weeks-show.flex-item-fixed
    weeks-display(:week='week')
      shared-link.action-text(:to='week.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import WeeksResource from '../../resources/weeks_resource'

export default
  props:
    parent_week: null
    week_id:
      default: null

  data: ->
    week: null

  methods:
    loadWeek: ->
      return unless @week_id
      @weeks_resource.get @week_id, @weekLoaded

    weekLoaded: (response) ->
      @week = response.week

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @week = @parent_week if @parent_week
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    week_id:
      immediate: true
      handler: ->
        @weeks_resource ?= new WeeksResource
        @loadWeek()
</script>
