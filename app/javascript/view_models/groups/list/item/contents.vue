<template lang="pug">
router-link.group-list-item-contents(:to='group.path()')
  | {{ group.name }}
</template>

<script lang="coffee">
  export default
    props:
      group:
        required: true
</script>
