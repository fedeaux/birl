<template lang="pug">
  .goaler
    .goal-period(v-for='period in goal_periods')
      .goal-period-name {{ period.name }}
      template(:is="''")
</template>

<script lang="coffee">
  import Goal from '../../models/goal'
  import GoalGroup from '../../models/goal_group'

  export default
    data: ->
      goal_groups: []

    methods:
      loadGoalGroups: ->
        @goal_periods = [
          {
            name: 'Yesterday'
            goals: [
              new Goal(
                name: 'Commit to sleep @ 23:30 Yesterday'
              )
            ],
          },
          {
            name: 'Today'
            goals: [
              new GoalGroup(
                name: 'Runa'
                goals: [
                  { name: '5h on SquadRon' }
                  { name: 'Review one PR' }
                ]
              ),
            ]
          }
        ]

    created: ->
      @loadGoalGroups()
</script>
