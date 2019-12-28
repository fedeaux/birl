<template lang="pug">
.entity-display(v-if="vocabulary")
  .entity-display-main
    | {{ vocabulary.pt_br }}
    | &nbsp;&rarr;&nbsp;
    | {{ vocabulary.es }}

  .entity-display-detail
    //- BrainDamage: Details Start
    | {{ vocabulary.kind }}
    //- BrainDamage: Details End

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      vocabulary:
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
