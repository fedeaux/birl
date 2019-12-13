<template lang="pug">
router-link.session-list-item-contents(:to='session.path()')
  | {{ session.name }}
</template>

<script lang="coffee">
  export default
    props:
      session:
        required: true
</script>
