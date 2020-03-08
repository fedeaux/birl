<template lang="pug">
.entity-new.goal-entry-new.default-container
  .entity-display
    .entity-display-main New Goal Entry

  goal-entries-form(v-model='goal_entry'
                    @save='saveGoalEntry'
                    @cancel='back')
</template>

<script lang="coffee">

import GoalEntriesResource from '../../resources/goal_entries_resource'
import GoalEntry from '../../models/goal_entry'

export default
  data: ->
    goal_entry: new GoalEntry

  methods:
    saveGoalEntry: ->
      @goal_entries_resource.save @goal_entry, @saved

    saved: (data) ->
      @$router.push data.goal_entry.path()

    back: ->
      @$router.push @goal_entry.collectionPath()

  mounted: ->
    @goal_entries_resource = new GoalEntriesResource
</script>
