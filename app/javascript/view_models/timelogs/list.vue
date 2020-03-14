<template lang="pug">
.entity-list.timelog-list.default-container.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item
    timelogs-list-item(v-for='timelog in displayable_timelogs'
                       v-if='timelogs'
                       :timelog='timelog'
                       :allow_actions='allow_actions'
                       :key='timelog.id'
                       @edit='$emit("edit", { timelog: timelog })'
                       @destroy='$emit("destroy", { timelog: timelog })')

    entity-list-empty(v-if='!timelogs || timelogs.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    timelogs:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (timelog) ->
      (@filter.text == '' or timelog.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_timelogs: ->
      return [] unless @timelogs

      (timelog for timelog in @timelogs when @matchFilters timelog)
</script>
