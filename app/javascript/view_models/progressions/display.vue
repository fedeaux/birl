<template lang="pug">
.entity-display(v-if="progression")
  .entity-display-main
    | {{ progression.exercise_name }}

  .entity-display-detail
    | {{ progression.challenge_name }}

    template(v-if='progression.details')
      |  &middot;
      |  {{ progression.details }}
    |  &middot;
    template(v-if='progression.entries_count > 0')
      |  {{ progression.entries_count }} entries
    template(v-else)
      |  Never trained
    template(v-if='progression.last_entry_at')
      |  &middot;
      |  {{ progression.last_entry_at.fromNow() }}

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      progression:
        required: true

      allow_actions:
        default: true

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event
</script>
