<template lang="pug">
  .timeline-step(@mousedown='mousedown' @mouseup='mouseup')
    .timeline-step-time
      | {{ time }}
    .timeline-step-space
</template>

<script lang="coffee">
  export default
    props: ['step']

    methods:
      mousedown: ->
        @$emit 'selectionStarted', { step: @step }

      mouseup: ->
        @$emit 'selectionFinished', { step: @step }

    computed:
      time: ->
        @step.format('HH:mm')
</script>
