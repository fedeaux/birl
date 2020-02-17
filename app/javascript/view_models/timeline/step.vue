<template lang="pug">
  .timeline-step
    .timeline-step-time
      | {{ time }}
    .timeline-step-space
</template>

<script lang="coffee">
  export default
    props: ['step']

    computed:
      time: ->
        @step.format('HH:mm')
</script>
