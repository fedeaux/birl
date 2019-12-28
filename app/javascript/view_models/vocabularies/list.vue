<template lang="pug">
.entity-list.vocabulary-list.default-container
  vocabularies-list-item(v-for='vocabulary in vocabularies'
                         v-if='vocabularies'
                         :vocabulary='vocabulary'
                         :allow_actions='allow_actions'
                         :key='vocabulary.id'
                         @edit='$emit("edit", { vocabulary: vocabulary })'
                         @destroy='$emit("destroy", { vocabulary: vocabulary })')

  entity-list-empty(v-if='!vocabularies || vocabularies.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    vocabularies:
      default: null
</script>
