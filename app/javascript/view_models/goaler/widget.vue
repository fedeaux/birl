<template lang="pug">
  .goaler
    .goals
      .goal
        h1
          | Body of diamond.
        | The four feats of superhuman strength.
        | Viver 100 anos.
        | 5112.

      .goal
        h1
          | Master of the arts.

      .goal
        h1
          | Master of knowledge

        ul
          li Biology
            ul
              li Neuroscience
              li Evolution
              li Psychology
              li Sports Science

          li Psychology
            ul
              li Clinicians
                ul
                  li Freud
                  li Jung
                  li Fleder
                  li Carl Rogers
                  li Skinner
            ul
              li Animal Behaviour

          li Economics & Sociology
            ul
              li Macro
              li Micro
              li Marxs

          li History
            ul
              li Old civilizations
              li Brazil
              li Revolutions
              li Empires
              li Ideologies
                ul
                  li Cristianity
                  li Buddhism

          li Philosophy
            ul
              li Greek
              li German
              li Buddhist

          li Math
            ul
              li Computer Science
              li Computer Theory
              li Physics
              li Statistics
              li Calculus

          li Art
            ul
              li Guitar
              li Drawing

      .goal
        h1
          | Bilianzanbilianz
          | Get a highly paid (includes stock), technical, leadership-oriented, at runa

    //- .flex-row.h-paddeds-1-list
    //-   .goal-period.flex-item(v-for='period in goals_periods')
    //-     .goal-period-header
    //-       .goal-period-header-name {{ period.name }}
    //-     .goal-period-body.v-paddeds-2-list
    //-       component(v-for='item in period.items' :item='item' :is="'goaler-widget-'+item.widgetComponent()")
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
