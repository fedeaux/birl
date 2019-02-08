<template lang="pug">
.entity-edit.entry-edit.default-container
  entries-form(:entry_id='entry_id')
</template>

<script lang="coffee">
export default
  computed:
    entry_id: ->
      @$route.params.id
</script>
