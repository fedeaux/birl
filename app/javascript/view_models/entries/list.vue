<template lang="pug">
.entity-list.entry-list.default-container
  entries-list-item(v-for='entry in entries' v-if='entries' :entry='entry')
  entity-list-empty(v-if='!entries || entries.length == 0')
</template>

<script lang="coffee">
export default
  props:
    entries:
      default: null
</script>
