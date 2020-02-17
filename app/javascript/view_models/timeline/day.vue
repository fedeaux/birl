<template lang="pug">
  .timeline
    timeline-step(v-for='step in steps' :step='step')

    timeline-item(v-for='timelineable in timelineables'
                  :timelineable='timelineable'
                  :key='timelineable.id')
</template>

<script lang="coffee">
  export default
    props:
      grid:
        default: 10

      start:
        default: -> moment().startOf('day')

      finish:
        default: -> moment().endOf('day')

      timelineables:
        required: true

    computed:
      total_minutes: ->
        Math.round moment.duration(@finish.diff(@start)).asMinutes()

      number_of_steps: ->
        @total_minutes / @grid

      steps: ->
        (moment(@start).add(@grid * step, 'minutes') for step in [0..@number_of_steps])
</script>
