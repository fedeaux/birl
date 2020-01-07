<template lang="pug">
.tags-tags(v-if="tags && tags.length > 0")
  tags-tag(v-for='tag in tags' :tag='tag' :display='display')
</template>

<script lang="coffee">
  export default
    props:
      display:
        default: 'fullname'

      tags:
        required: true
</script>
