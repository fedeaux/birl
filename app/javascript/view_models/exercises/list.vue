<template lang="pug">
.entity-list.exercise-list.default-container
  exercises-list-item(v-for='exercise in exercises'
                      v-if='exercises'
                      :exercise='exercise'
                      :allow_actions='allow_actions'
                      :key='exercise.id'
                      @edit='$emit("edit", { exercise: exercise })'
                      @destroy='$emit("destroy", { exercise: exercise })')

  entity-list-empty(v-if='!exercises || exercises.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    exercises:
      default: null
</script>
