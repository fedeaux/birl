<template lang="pug">
  .goaler
    .goal-period.v-padded-2(v-for='period in goal_periods')
      .goal-period-header
        .goal-period-header-name {{ period.name }}
      .goal-period-body.v-paddeds-2-list
        component(v-for='item in period.items' :item='item' :is="'goaler-widget-'+item.widgetComponent()")
</template>

<script lang="coffee">
  import Goal from '../../models/goal'
  import GoalGroup from '../../models/goal_group'

  export default
    data: ->
      goal_groups: []

    methods:
      loadGoalPeriods: ->
        @goal_periods = [
          {
            name: 'Yesterday'
            items: [
              new Goal(
                name: 'Do not smoke weed after 21:00'
                type: 'yes-no'
              )
              new Goal(
                name: 'Commit to sleep @ 23:00'
                type: 'yes-no'
              )
              new GoalGroup(
                name: 'Runa'
                goals: [
                  { name: 'Review one PR', type: 'yes-no' }
                ]
              ),
            ]
          },
          {
            name: 'Today'
            items: [
              new GoalGroup(
                name: 'Runa'
                goals: [
                  { name: '5h on SquadRon', type: 'timelog-track' }
                  { name: 'Review one PR', type: 'yes-no' }
                ]
              ),
            ]
          },
          {
            name: 'This week'
            items: [
              new GoalGroup(
                name: 'Runa'
                goals: [
                  { name: '25h on SquadRon', type: 'timelog-track' }
                  { name: '5h on Front end architecture', type: 'timelog-track' }
                  { name: '5h on QAA', type: 'timelog-track' }
                ]
              ),
            ]
          }
        ]

    created: ->
      @loadGoalPeriods()
      console.log @goal_periods
</script>
