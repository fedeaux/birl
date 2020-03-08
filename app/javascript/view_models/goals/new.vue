<template lang="pug">
.entity-new.goal-new.default-container
  .entity-display
    .entity-display-main New Goal

  goals-form(v-model='goal'
             @save='saveGoal'
             @cancel='back')
</template>

<script lang="coffee">

import GoalsResource from '../../resources/goals_resource'
import Goal from '../../models/goal'

export default
  data: ->
    goal: new Goal

  methods:
    saveGoal: ->
      @goals_resource.save @goal, @saved

    saved: (data) ->
      @$router.push data.goal.path()

    back: ->
      @$router.push @goal.collectionPath()

  mounted: ->
    @goals_resource = new GoalsResource
</script>
