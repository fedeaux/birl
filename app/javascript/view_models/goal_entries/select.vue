<template lang="pug">
  shared-modal(v-if='form_goal_entry' title='New Goal Entry')
    goal-entries-form(v-model='form_goal_entry'
                   @save='saveFormGoalEntry()'
                   @cancel='clearFormGoalEntry()')

  sui-dropdown(:options='goal_entries_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Goal Entry'
               v-else
               v-model='selected_goal_entry_id')

</template>

<script lang="coffee">
import GoalEntriesManagerMixin from '../../mixins/goal_entries/manager'

export default
  mixins: [GoalEntriesManagerMixin]

  model:
    prop: 'goal_entry_id'

  props:
    goal_entry_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_goal_entry_id: null

  methods:
    goalEntryAdded: (index, goalEntry) ->
      @selectGoalEntry goal_entry

    selectGoalEntry: (goal_entry) ->
      @selected_goal_entry_id = parseInt goal_entry.id

  computed:
    loading: ->
      !@goal_entries

    goal_entries_as_options: ->
      return [] unless @goal_entries
      { key: goal_entry.id, value: goal_entry.id, text: goal_entry.name } for goal_entry in @goal_entries

  watch:
    selected_goal_entry_id: ->
      selected_goal_entry_id = parseInt @selected_goal_entry_id

      unless isNaN selected_goal_entry_id
        @$emit 'input', selected_goal_entry_id
        return

      @newGoalEntry name: @selected_goal_entry_id

    goal_entry_id:
      immediate: true
      handler: ->
        return unless @goal_entry_id
        @selected_goal_entry_id = parseInt @goal_entry_id

</script>
