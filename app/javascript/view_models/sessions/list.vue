<template lang="pug">
.entity-list.session-list.default-container.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item
    sessions-list-item(v-for='session in displayable_sessions'
                       v-if='sessions'
                       :session='session'
                       :allow_actions='allow_actions'
                       :key='session.id'
                       @edit='$emit("edit", { session: session })'
                       @destroy='$emit("destroy", { session: session })')

    entity-list-empty(v-if='!sessions || sessions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    sessions:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (session) ->
      (@filter.text == '' or session.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_sessions: ->
      return [] unless @sessions

      (session for session in @sessions when @matchFilters session)
</script>
