<template lang="pug">
.entity-display(v-if="tag")
  .entity-display-main
    i.caret.down.icon(v-if='state == "open"' @click='$emit("toogleState")')
    i.caret.right.icon(v-else-if='state === "closed"' @click='$emit("toogleState")')
    i.blank.icon(v-else)
    tags-tag(:tag='tag' display='fullname')

    .entity-display-detail
      //- BrainDamage: Details Start
      //- BrainDamage: Details End

  .top-right-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      state:
        default: null

      tag:
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
