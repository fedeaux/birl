<template lang="pug">
.entity-edit.goal_entry-edit.default-container
  .entity-display
    .entity-display-main Edit Goal Entry

  goal-entries-form(v-model='goal_entry'
                    v-if='goal_entry'
                    @save='saveGoalEntry()'
                    @cancel='goalEntryDone()')
</template>

<script lang="coffee">

import GoalEntriesResource from '../../resources/goal_entries_resource'
import GoalEntry from '../../models/goal_entry'

export default
  props:
    goal_entry_id:
      default: null

  data: ->
    goal_entry: null

  methods:
    loadGoalEntry: ->
      @goal_entries_resource.get @goal_entry_id, @goalEntryLoaded

    goalEntryLoaded: (response) ->
      @goal_entry = response.goal_entry

    saveGoalEntry: ->
      @goal_entries_resource.save @goal_entry, @goalEntryDone

    goalEntryDone: ->
      @$router.push @goal_entry.path()

  mounted: ->
    @goal_entries_resource = new GoalEntriesResource
    @loadGoalEntry()
</script>
