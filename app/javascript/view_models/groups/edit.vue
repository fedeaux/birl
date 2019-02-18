<template lang="pug">
.entity-edit.group-edit.default-container
  groups-form(:group_id='group_id')
</template>

<script lang="coffee">
export default
  computed:
    group_id: ->
      @$route.params.id
</script>
