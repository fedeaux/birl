<template lang="pug">
.entity-display(v-if="context")
  .entity-display-main
    | {{ context.name }}

  .entity-display-detail
    | {{ context.color }}

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      context:
        required: true

      allow_actions:
        default: true

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event
</script>
