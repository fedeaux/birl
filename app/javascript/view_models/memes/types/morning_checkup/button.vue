<template lang="pug">
  .performed-state(v-if='performed')
    .performed-state-label Woke up @ 2pm
  .ui.fluid.button(:class='"blue"' @click='performMorningCheckup' v-else) Morning Checkup
</template>

<script lang="coffee">
  export default
    data: ->
      performed: true
</script>
