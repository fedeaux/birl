<template lang="pug">
.entity-display(v-if="session")
  .entity-display-main
    | {{ session.name }}

  .entity-display-detail
    | {{ session.human_weekday }}
    | &middot;
    | {{ session.updated_at.fromNow() }}

  .entity-display-actions(v-if='allow_actions' @click='$emit("click", $event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      session:
        required: true

      allow_actions:
        default: true
</script>
