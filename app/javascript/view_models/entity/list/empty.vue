<template lang="pug">
  .entity-list-empty(v-if='!global_loading')
    | {{ text }}
</template>

<script lang="coffee">
export default
  props:
    text:
      default: 'This list is empty'
</script>
