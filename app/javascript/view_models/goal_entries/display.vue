<template lang="pug">
.entity-display(v-if="goal_entry")
  .entity-display-main
    | {{ goal_entry.name }}

    .entity-display-detail
      //- BrainDamage: Details Start
      //- BrainDamage: Details End

  .top-right-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      goal_entry:
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
