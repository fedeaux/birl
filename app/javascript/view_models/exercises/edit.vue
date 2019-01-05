<template lang="pug">
.entity-edit.exercise-edit.default-container
  exercises-form(:exercise_id='exercise_id')
</template>

<script lang="coffee">
export default
  computed:
    subscription_id: ->
      @$route.params.id
</script>
