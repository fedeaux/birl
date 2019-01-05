<template lang="pug">
.entity-list.session-list.default-container
  sessions-list-item(v-for='session in sessions' v-if='sessions' :session='session' :key='session.id')
  entity-list-empty(v-if='!sessions || sessions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    sessions:
      default: null
</script>
