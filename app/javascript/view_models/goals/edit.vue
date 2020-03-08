<template lang="pug">
.entity-edit.goal-edit.default-container
  .entity-display
    .entity-display-main Edit Goal

  goals-form(v-model='goal'
             v-if='goal'
             @save='saveGoal()'
             @cancel='goalDone()')
</template>

<script lang="coffee">

import GoalsResource from '../../resources/goals_resource'
import Goal from '../../models/goal'

export default
  props:
    goal_id:
      default: null

  data: ->
    goal: null

  methods:
    loadGoal: ->
      @goals_resource.get @goal_id, @goalLoaded

    goalLoaded: (response) ->
      @goal = response.goal

    saveGoal: ->
      @goals_resource.save @goal, @goalDone

    goalDone: ->
      @$router.push @goal.path()

  mounted: ->
    @goals_resource = new GoalsResource
    @loadGoal()
</script>
