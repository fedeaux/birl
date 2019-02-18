<template lang="pug">
.entity-list.group-list.default-container
  groups-list-item(v-for='group in groups' v-if='groups' :group='group' :key='group.id')
  entity-list-empty(v-if='!groups || groups.length == 0')
</template>

<script lang="coffee">
export default
  props:
    groups:
      default: null
</script>
