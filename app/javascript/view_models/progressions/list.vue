<template lang="pug">
.entity-list.progression-list.default-container
  progressions-list-item(v-for='progression in progressions'
                         v-if='progressions'
                         :progression='progression'
                         :allow_actions='allow_actions'
                         :key='progression.id'
                         @edit='$emit("edit", { progression: progression })'
                         @destroy='$emit("destroy", { progression: progression })')

  entity-list-empty(v-if='!progressions || progressions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    progressions:
      default: null
</script>
