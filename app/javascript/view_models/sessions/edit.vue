<template lang="pug">
.entity-edit.session-edit.default-container
  sessions-form(:session_id='session_id')
</template>

<script lang="coffee">
export default
  computed:
    session_id: ->
      @$route.params.id
</script>
