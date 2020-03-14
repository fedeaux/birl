<template lang="pug">
.progression-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .progressions-list-items-wrapper
      progressions-list-item(v-for='progression in displayable_progressions'
                             v-if='progressions'
                             :progression='progression'
                             :allow_actions='allow_actions'
                             :key='progression.id'
                             @edit='$emit("edit", { progression: progression })'
                             @destroy='$emit("destroy", { progression: progression })')

      entity-list-empty(v-if='!progressions || progressions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    progressions:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (progression) ->
      (@filter.text == '' or progression.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_progressions: ->
      return [] unless @progressions

      (progression for progression in @progressions when @matchFilters progression)
</script>
