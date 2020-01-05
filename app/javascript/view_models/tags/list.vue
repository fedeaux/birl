<template lang="pug">
.entity-list.tag-list.default-container
  tags-list-item(v-for='tag in tags'
                 v-if='tags'
                 :tag='tag'
                 :allow_actions='allow_actions'
                 :key='tag.id'
                 @edit='$emit("edit", { tag: tag })'
                 @destroy='$emit("destroy", { tag: tag })')

  entity-list-empty(v-if='!tags || tags.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    tags:
      default: null
</script>
