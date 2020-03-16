<template lang="pug">
.day-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .days-list-items-wrapper
      days-list-item(v-for='day in displayable_days'
                     v-if='days'
                     :day='day'
                     :allow_actions='allow_actions'
                     :key='day.id'
                     @edit='$emit("edit", { day: day })'
                     @destroy='$emit("destroy", { day: day })')

      entity-list-empty(v-if='!days || days.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    days:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (day) ->
      (@filter.text == '' or day.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_days: ->
      return [] unless @days

      (day for day in @days when @matchFilters day)
</script>
