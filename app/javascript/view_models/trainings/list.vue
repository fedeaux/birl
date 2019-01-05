<template lang="pug">
.entity-list.training-list.default-container
  trainings-list-item(v-for='training in trainings' v-if='trainings' :training='training' :key='training.id')
  entity-list-empty(v-if='!trainings || trainings.length == 0')
</template>

<script lang="coffee">
export default
  props:
    trainings:
      default: null
</script>
