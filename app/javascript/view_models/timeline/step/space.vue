<template lang="pug">
  .timeline-step-space(:class='{ even: parseInt(step.minutes() / 10) % 2 == 0 }'
                       @mousedown='mousedown'
                       @mouseout='mouseout'
                       @mouseup='mouseup'
                       @click='click')
    | &nbsp;
</template>

<script lang="coffee">
  export default
    props:
      step:
        required: true

      show_time:
        default: true

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
