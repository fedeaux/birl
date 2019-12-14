<template lang="pug">
.entity-display(v-if="training")
  .entity-display-main
    | {{ training.name }}

  .entity-display-detail
    | detail1
    | &middot;
    | detail2

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      training:
        required: true

      allow_actions:
        default: true

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event
</script>
