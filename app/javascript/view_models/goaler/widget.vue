<template lang="pug">
  .goaler.flex-row.h-paddeds-1-list
    .goal-period.flex-item(v-for='period in goals_periods')
      .goal-period-header
        .goal-period-header-name {{ period.name }}
      .goal-period-body.v-paddeds-2-list
        component(v-for='item in period.items' :item='item' :is="'goaler-widget-'+item.widgetComponent()")
</template>

<script lang="coffee">
  import GoalsPeriodsResource from '../../resources/goals_periods_resource'
  import Goal from '../../models/goal'
  import GoalItem from '../../models/goal'
  import GoalGroup from '../../models/goal_group'

  export default
    props:
      base_date:
        default: -> moment()

    data: ->
      goals_periods: []

    methods:
      loadGoalPeriods: ->
        @goals_periods_resource ?= new GoalsPeriodsResource
        @goals_periods_resource.index @goalPeriodsLoaded, base_date: @base_date.format()

      goalPeriodsLoaded: (data) ->
        @goals_periods = data.goals_periods

    created: ->
      @loadGoalPeriods()
</script>
