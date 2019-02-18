<template lang="pug">
.entity-edit.progression-edit.default-container
  progressions-form(:progression_id='progression_id')
</template>

<script lang="coffee">
export default
  computed:
    progression_id: ->
      @$route.params.id
</script>
