<template lang="pug">
.entity-list.group-list.default-container
  groups-list-item(v-for='group in groups'
                   v-if='groups'
                   :group='group'
                   :allow_actions='allow_actions'
                   :key='group.id'
                   @edit='$emit("edit", { group: group })'
                   @destroy='$emit("destroy", { group: group })')

  entity-list-empty(v-if='!groups || groups.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    groups:
      default: null
</script>
