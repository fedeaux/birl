<template lang="pug">
.goal-entries-show-wrapper.flex-column.t-padded-2(v-if='goal_entry')
  .goal-entries-show.flex-item-fixed
    goal-entries-display(:goal_entry='goal_entry')
      shared-link.action-text(:to='goal_entry.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import GoalEntriesResource from '../../resources/goal_entries_resource'

export default
  props:
    parent_goal_entry: null
    goal_entry_id:
      default: null

  data: ->
    goal_entry: null

  methods:
    loadGoalEntry: ->
      return unless @goal_entry_id
      @goal_entries_resource.get @goal_entry_id, @goalEntryLoaded

    goalEntryLoaded: (response) ->
      @goal_entry = response.goal_entry

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @goal_entry = @parent_goal_entry if @parent_goal_entry
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    goal_entry_id:
      immediate: true
      handler: ->
        @goal_entries_resource ?= new GoalEntriesResource
        @loadGoalEntry()
</script>
