<template lang="pug">
.entity-display(v-if="challenge")
  .entity-display-main
    | {{ challenge.name }}

  .entity-display-detail
    //- BrainDamage: Details Start
    | {{ challenge.description }}
    //- BrainDamage: Details End

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

    # BrainDamage: Other Start
    # BrainDamage: Other End
</script>
