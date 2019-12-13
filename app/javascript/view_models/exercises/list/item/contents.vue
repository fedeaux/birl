<template lang="pug">
router-link.exercise-list-item-contents(:to='exercise.path()')
  | {{ exercise.name }}
</template>

<script lang="coffee">
  export default
    props:
      exercise:
        required: true
</script>
