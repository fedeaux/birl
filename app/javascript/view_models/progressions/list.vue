<template lang="pug">
.entity-list.progression-list.default-container
  progressions-list-item(v-for='progression in progressions' v-if='progressions' :progression='progression')
  entity-list-empty(v-if='!progressions || progressions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    progressions:
      default: null
</script>
