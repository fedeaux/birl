<template lang="pug">
  .flex-views
    .flex-view
      shared-view(:path='"/tags"')
    .flex-view.grow-2
      shared-view(:path='"/timelogs/today"')
    .flex-view
      shared-view(:path='"/memes"')
</template>

<script lang="coffee">
  export default {}
</script>
