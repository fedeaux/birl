<template lang="pug">
.group-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .groups-list-items-wrapper
      groups-list-item(v-for='group in displayable_groups'
                       v-if='groups'
                       :group='group'
                       :allow_actions='allow_actions'
                       :key='group.id'
                       @edit='$emit("edit", { group: group })'
                       @destroy='$emit("destroy", { group: group })')

      entity-list-empty(v-if='!groups || groups.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    groups:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (group) ->
      (@filter.text == '' or group.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_groups: ->
      return [] unless @groups

      (group for group in @groups when @matchFilters group)
</script>
