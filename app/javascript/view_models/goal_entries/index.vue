<template lang="pug">
goal-entries-manager.goal-entries-index(:parent_goal_entries='goal_entries')
</template>

<script lang="coffee">
import GoalEntriesResource from '../../resources/goal_entries_resource'

export default
  data: ->
    goal_entries: null

  methods:
    loadGoalEntries: ->
      @goal_entries_resource.index @goalEntriesLoaded

    goalEntriesLoaded: (response) ->
      @goal_entries = response.goal_entries

  mounted: ->
    @goal_entries_resource = new GoalEntriesResource
    @loadGoalEntries()
</script>
