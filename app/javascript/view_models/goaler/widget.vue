<template lang="pug">
  .goaler
    .goal-period.v-padded-2(v-for='period in goals_periods')
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
        # @goal_periods = [
        #   {
        #     name: 'Yesterday'
        #     items: [
        #       new Goal(
        #         name: 'Do not smoke weed after 21:00'
        #         type: 'yes-no'
        #       )
        #       new Goal(
        #         name: 'Commit to sleep @ 23:00'
        #         type: 'yes-no'
        #       )
        #       new GoalGroup(
        #         name: 'Runa'
        #         goals: [
        #           { name: 'Review one PR', type: 'yes-no' }
        #         ]
        #       ),
        #     ]
        #   },
        #   {
        #     name: 'Today'
        #     items: [
        #       new GoalGroup(
        #         name: 'Runa'
        #         goals: [
        #           { name: '5h on SquadRon', type: 'timelog-track' }
        #           { name: 'Review one PR', type: 'yes-no' }
        #         ]
        #       ),
        #     ]
        #   },
        #   {
        #     name: 'This week'
        #     items: [
        #       new GoalGroup(
        #         name: 'Runa'
        #         goals: [
        #           { name: '25h on SquadRon', type: 'timelog-track' }
        #           { name: '5h on Front end architecture', type: 'timelog-track' }
        #           { name: '5h on QAA', type: 'timelog-track' }
        #         ]
        #       ),
        #     ]
        #   }
        # ]

    created: ->
      @loadGoalPeriods()
      console.log @goal_periods
</script>
