<template lang="pug">
.entity-list.context-list.default-container
  contexts-list-item(v-for='context in contexts'
                     v-if='contexts'
                     :context='context'
                     :allow_actions='allow_actions'
                     :key='context.id'
                     @edit='$emit("edit", { context: context })'
                     @destroy='$emit("destroy", { context: context })')

  entity-list-empty(v-if='!contexts || contexts.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    contexts:
      default: null
</script>
