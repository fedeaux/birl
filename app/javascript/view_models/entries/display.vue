<template lang="pug">
.entity-display(v-if="entry")
  .entity-display-main
    entries-value-display(:value='entry.value')

  .entity-display-detail
    |  {{ entry.created_at.fromNow() }}
    template(v-if='entry.observations')
      |  &middot;
      |  {{ entry.observations }}

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      entry:
        required: true

      allow_actions:
        default: true

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event

</script>
