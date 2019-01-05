<template lang="pug">
.entity-list.exercise-list.default-container
  exercises-list-item(v-for='exercise in exercises' v-if='exercises' :exercise='exercise' :key='exercise.id')
  entity-list-empty(v-if='!exercises || exercises.length == 0')
</template>

<script lang="coffee">
export default
  props:
    exercises:
      default: null
</script>
