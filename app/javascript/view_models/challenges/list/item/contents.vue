<template lang="pug">
router-link.challenge-list-item-contents(:to='challenge.path()')
  | {{ challenge.name }}
  .entity-list-item-detail {{ challenge.description }}
</template>

<script lang="coffee">
  export default
    props:
      challenge:
        required: true
</script>
