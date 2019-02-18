<template lang="pug">
.entity-edit.training-edit.default-container
  trainings-form(:training_id='training_id')
</template>

<script lang="coffee">
export default
  computed:
    training_id: ->
      @$route.params.id
</script>
