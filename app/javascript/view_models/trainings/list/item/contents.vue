<template lang="pug">
router-link.training-list-item-contents(:to='training.path()')
  | {{ training.name }}
</template>

<script lang="coffee">
  export default
    props:
      training:
        required: true
</script>
