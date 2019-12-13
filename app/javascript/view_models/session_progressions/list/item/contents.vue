<template lang="pug">
router-link.session_progression-list-item-contents(:to='session_progression.path()')
  | {{ session_progression.name }}
</template>

<script lang="coffee">
  export default
    props:
      session_progression:
        required: true
</script>
