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
                  @destroy='$emit("destroy", { timelog: timelineable })'
                  @startDragging='startDragging')
</template>

<script lang="coffee">
  export default
    data: ->
      current_selection: null
      selections: []
      timer_interval: null
      hora_certa: null
      timelineables_at_rule: []

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

        if @current_selection
          @$emit 'rangeSelected', @current_selection
          @current_selection.finished = true

      updateCurrentSelection: (data) ->
        if !@current_selection or @current_selection.finished
          return @$emit 'stepHovered', data

        @current_selection.finish = data.step.clone().add @grid, 'minutes'

        if @current_selection.finish.isBefore @current_selection.start
          [@current_selection.start, @current_selection.finish] = [@current_selection.finish, @current_selection.start]

        @current_selection.range = moment().range(@current_selection.start, @current_selection.finish.clone().subtract(1, 'second'))

      isSelected: (step) ->
        return false unless @current_selection and @current_selection.start
        return step.isSame(@current_selection.start) unless @current_selection.finish

        @current_selection.range.contains step

      clockTick: ->
        timenow = moment()
        return @hora_certa = null unless timenow.isAfter(@start) and timenow.isBefore(@finish)
        @hora_certa = timenow
        return unless @timelineables

        new_timelineables_at_rule = @timelineables.filter (timelineable) =>
          (@hora_certa.isAfter(timelineable.start) and @hora_certa.isBefore(timelineable.finish))

        added_timelineables = _.difference new_timelineables_at_rule, @timelineables_at_rule
        removed_timelineables = _.difference @timelineables_at_rule, new_timelineables_at_rule

        @notifyCurrentTimelineables added_timelineables, removed_timelineables

        @timelineables_at_rule = new_timelineables_at_rule

      startDragging: (data) ->
        @current_selection = null
        @$emit 'startDragging', data

      notifyCurrentTimelineables: (added_timelineables, removed_timelineables) ->
        return if added_timelineables.length == 0

        Global.events.$emit 'Notify', title: 'Starting now', options: { body: "#{added_timelineables[0].main_tag.fullname}" }

    created: ->
      @timer_interval = setInterval (=> @clockTick()), 1000

    beforeDestroy: ->
      clearInterval @timer_interval
</script>
