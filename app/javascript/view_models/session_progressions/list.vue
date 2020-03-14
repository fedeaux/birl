<template lang="pug">
.entity-list.session-progression-list.default-container.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item
    session-progressions-list-item(v-for='session_progression in displayable_session_progressions'
                                   v-if='session_progressions'
                                   :session_progression='session_progression'
                                   :allow_actions='allow_actions'
                                   :key='session_progression.id'
                                   @edit='$emit("edit", { session_progression: session_progression })'
                                   @destroy='$emit("destroy", { session_progression: session_progression })')

    entity-list-empty(v-if='!session_progressions || session_progressions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    session_progressions:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (session_progression) ->
      (@filter.text == '' or session_progression.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_session_progressions: ->
      return [] unless @session_progressions

      (session_progression for session_progression in @session_progressions when @matchFilters session_progression)
</script>
