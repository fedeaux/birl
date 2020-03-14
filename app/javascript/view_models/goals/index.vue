<template lang="pug">
goals-manager.goals-index(:parent_goals='goals')
</template>

<script lang="coffee">
import GoalsResource from '../../resources/goals_resource'

export default
  data: ->
    goals: null

  methods:
    loadGoals: ->
      @goals_resource.index @goalsLoaded

    goalsLoaded: (response) ->
      @goals = response.goals

  mounted: ->
    @goals_resource = new GoalsResource
    @loadGoals()
</script>
