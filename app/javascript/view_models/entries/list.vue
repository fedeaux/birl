<template lang="pug">
.entry-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .entries-list-items-wrapper
      entries-list-item(v-for='entry in displayable_entries'
                        v-if='entries'
                        :entry='entry'
                        :allow_actions='allow_actions'
                        :key='entry.id'
                        @edit='$emit("edit", { entry: entry })'
                        @destroy='$emit("destroy", { entry: entry })')

      entity-list-empty(v-if='!entries || entries.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    entries:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (entry) ->
      (@filter.text == '' or entry.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_entries: ->
      return [] unless @entries

      (entry for entry in @entries when @matchFilters entry)
</script>
