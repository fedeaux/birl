<template lang="pug">
.entity-list.goal-entry-list.default-container.header-contents-footer
  .header-contents-footer-header
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .header-contents-footer-contents
    goal-entries-list-item(v-for='goal_entry in displayable_goal_entries'
                           v-if='goal_entries'
                           :goal_entry='goal_entry'
                           :allow_actions='allow_actions'
                           :key='goal_entry.id'
                           @edit='$emit("edit", { goal_entry: goal_entry })'
                           @destroy='$emit("destroy", { goal_entry: goal_entry })')

    entity-list-empty(v-if='!goal_entries || goal_entries.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    goal_entries:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (goal_entry) ->
      (@filter.text == '' or goal_entry.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_goal_entries: ->
      return [] unless @goal_entries

      (goal_entry for goal_entry in @goal_entries when @matchFilters goal_entry)
</script>
