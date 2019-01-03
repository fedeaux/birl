<template lang="pug">
.entity-list.challenge-list.default-container
  challenges-list-item(v-for='challenge in challenges' v-if='challenges' :challenge='challenge')
  entity-list-empty(v-if='!challenges || challenges.length == 0')
</template>

<script lang="coffee">
export default
  props:
    challenges:
      default: null
</script>
