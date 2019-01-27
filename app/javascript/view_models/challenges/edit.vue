<template lang="pug">
.entity-edit.challenge-edit.default-container
  challenges-form(:challenge_id='challenge_id')
</template>

<script lang="coffee">
export default
  computed:
    challenge_id: ->
      @$route.params.id
</script>
