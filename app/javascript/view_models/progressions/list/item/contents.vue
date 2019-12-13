<template lang="pug">
router-link.progression-list-item-contents(:to='progression.path()') {{ progression.name }}
</template>

<script lang="coffee">
  export default
    props:
      progression:
        required: true
</script>
