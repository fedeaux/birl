<template lang="pug">
.entity-list.entry-list.default-container
  entries-list-item(v-for='entry in entries'
                    v-if='entries'
                    :entry='entry'
                    :controls='controls'
                    :key='entry.id'
                    @edit='$emit("edit", { entry: entry })'
                    @destroy='$emit("destroy", { entry: entry })')

  entity-list-empty(v-if='!entries || entries.length == 0')
</template>

<script lang="coffee">
export default
  props:
    controls:
      default: false

    entries:
      default: null
</script>
