<template lang="pug">
  .timeline
    timeline-rule(:at='hora_certa' :start='start')

    timeline-step(v-for='step in steps'
                  :step='step'
                  :class='{ selected: isSelected(step) }'
                  @selectionStarted='startASelection'
                  @selectionUpdated='updateCurrentSelection'
                  @selectionFinished='finishCurrentSelection')

    timeline-item(v-for='timelineable in timelineables'
                  :timelineable='timelineable'
                  :key='timelineable.id'
                  @edit='$emit("edit", { timelog: timelineable })'
                  @destroy='$emit("destroy", { timelog: timelineable })')
</template>

<script lang="coffee">
  export default
    data: ->
      current_selection: null
      selections: []
      timer_interval: null
      hora_certa: null

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
        (moment(@start).add(@grid * step, 'minutes') for step in [0...@number_of_steps])

    methods:
      startASelection: (data) ->
        @current_selection = { start: data.step, finish: false, range: null }

      finishCurrentSelection: (data) ->
        @updateCurrentSelection data
        @$emit 'rangeSelected', @current_selection
        @current_selection.finished = true

      updateCurrentSelection: (data) ->
        return if !@current_selection or @current_selection.finished

        @current_selection.finish = data.step.clone().add @grid, 'minutes'
        @current_selection.range = moment().range(@current_selection.start, @current_selection.finish.clone().subtract(1, 'second'))

      isSelected: (step) ->
        return false unless @current_selection and @current_selection.start
        return step.isSame(@current_selection.start) unless @current_selection.finish

        @current_selection.range.contains step

      clockTick: ->
        timenow = moment()
        return @hora_certa = null unless timenow.isAfter(@start) and timenow.isBefore(@finish)
        @hora_certa = timenow

    created: ->
      @timer_interval = setInterval (=> @clockTick()), 1000

    beforeDestroy: ->
      clearInterval @timer_interval
</script>
