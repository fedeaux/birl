<template lang="pug">
.entity-display(v-if="tag_taggable")
  .entity-display-main
    | {{ tag_taggable.name }}

  .entity-display-detail
    //- BrainDamage: Details Start
    //- BrainDamage: Details End

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      tag_taggable:
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
