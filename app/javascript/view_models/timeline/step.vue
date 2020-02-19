<template lang="pug">
  .timeline-step(@mousedown='mousedown' @mouseout='mouseout' @mouseup='mouseup' @click='click')
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

      mouseout: ->
        @$emit 'selectionUpdated', { step: @step }

      mouseup: ->
        @$emit 'selectionFinished', { step: @step }

      click: ->
        @$emit 'toggleStep', { step: @step }

    computed:
      time: ->
        @step.format('HH:mm')
</script>
