<template lang="pug">
.week-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .weeks-list-items-wrapper
      weeks-list-item(v-for='week in displayable_weeks'
                      v-if='weeks'
                      :week='week'
                      :allow_actions='allow_actions'
                      :key='week.id'
                      @edit='$emit("edit", { week: week })'
                      @destroy='$emit("destroy", { week: week })')

      entity-list-empty(v-if='!weeks || weeks.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    weeks:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (week) ->
      (@filter.text == '' or week.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_weeks: ->
      return [] unless @weeks

      (week for week in @weeks when @matchFilters week)
</script>
