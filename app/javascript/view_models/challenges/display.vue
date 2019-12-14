<template lang="pug">
.entity-display(v-if="challenge")
  .entity-display-main
    | {{ challenge.name }}

  .entity-display-detail
    | {{ challenge.description }}

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      challenge:
        required: true

      allow_actions:
        default: true

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event
</script>
