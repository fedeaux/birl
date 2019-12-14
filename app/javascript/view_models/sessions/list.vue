<template lang="pug">
.entity-list.session-list.default-container
  sessions-list-item(v-for='session in sessions'
                     v-if='sessions'
                     :session='session'
                     :allow_actions='allow_actions'
                     :key='session.id'
                     @edit='$emit("edit", { session: session })'
                     @destroy='$emit("destroy", { session: session })')

  entity-list-empty(v-if='!sessions || sessions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    sessions:
      default: null
</script>
