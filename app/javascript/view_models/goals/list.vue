<template lang="pug">
.goal-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .goals-list-items-wrapper
      goals-list-item(v-for='goal in displayable_goals'
                      v-if='goals'
                      :goal='goal'
                      :allow_actions='allow_actions'
                      :key='goal.id'
                      @edit='$emit("edit", { goal: goal })'
                      @destroy='$emit("destroy", { goal: goal })')

      entity-list-empty(v-if='!goals || goals.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    goals:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (goal) ->
      (@filter.text == '' or goal.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_goals: ->
      return [] unless @goals

      (goal for goal in @goals when @matchFilters goal)
</script>
