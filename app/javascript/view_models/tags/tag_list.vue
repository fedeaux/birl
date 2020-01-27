<template lang="pug">
.tags-tag-list
  .tags-tag-list-item(v-for='tag in tags')
    tags-tag(:tag='tag' display='fullname')
</template>

<script lang="coffee">
export default
  props:
    tags:
      default: null
</script>
