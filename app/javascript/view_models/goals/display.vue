<template lang="pug">
.entity-display(v-if="goal")
  .entity-display-main
    | {{ goal.name }}

  .entity-display-detail
    //- BrainDamage: Details Start
    //- BrainDamage: Details End

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      goal:
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
