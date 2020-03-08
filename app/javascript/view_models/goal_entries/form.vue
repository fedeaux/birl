<template lang="pug">
.entity-form-wrapper.goal-entries-form-wrapper.default-container(v-if='goal_entry')
  .entity-form.goal-entries-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='goal_entry.name')

      .field
        label Goal
        goals-select(v-model='goal_entry.goal_id')

      .field
        label Meta

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import GoalEntriesResource from '../../resources/goal_entries_resource'
import GoalEntry from '../../models/goal_entry'

export default
  model:
    prop: 'original_goal_entry'

  props:
    original_goal_entry: null

  data: ->
    goal_entry: null

  methods:
    save: ->
      @$emit 'input', @goal_entry
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_goal_entry:
      immediate: true
      deep: true
      handler: ->
        if @original_goal_entry
          @goal_entry = @original_goal_entry.clone()
        else
          @goal_entry = null
</script>
