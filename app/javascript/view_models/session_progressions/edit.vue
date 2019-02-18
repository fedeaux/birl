<template lang="pug">
.entity-edit.session_progression-edit.default-container
  session_progressions-form(:session_progression_id='session_progression_id')
</template>

<script lang="coffee">
export default
  computed:
    session_progression_id: ->
      @$route.params.id
</script>
