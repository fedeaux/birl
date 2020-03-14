<template lang="pug">
.entity-timeline.timelogs-timeline.flex-column(@mouseup='stopDragging')
  .flex-item-fixed
    h1.centered
      span.action-text(@click='backward')
        | &larr;

      span.contents(v-if='base_date')
        | {{ base_date.format('ddd, MMM DD') }}

      span.action-text(@click='forward')
        | &rarr;

    timelogs-day-planner(:base_date='base_date'
                         @dayPlanned='loadTimelogs')

    timelogs-timer(v-model='form_timelog'
                   @cancel='clearFormTimelog()'
                   @save='saveFormTimelog()'
                   @new='newTimelogWithRange')

  .flex-item
    timeline-day(v-if='timelogs'
                 :timelineables='all_timelogs'
                 :start='start'
                 :finish='finish'
                 @edit='editTimelog($event)'
                 @destroy='destroyTimelog($event)'
                 @rangeSelected='rangeSelected'
                 @startDragging='startDragging'
                 @stopDragging='stopDragging'
                 @stepHovered='stepHovered')
</template>

<script lang="coffee">
import TimelogsManagerMixin from '../../mixins/timelogs/manager'
import TimelogsResource from '../../resources/timelogs_resource'

export default
  mixins: [TimelogsManagerMixin]

  props:
    override_base_date:
      default: -> moment()

  data: ->
    range: false
    dragging_timelog: null
    dragging_handle: null
    base_date: @override_base_date.clone()

  methods:
    backward: ->
      @base_date = @base_date.clone().subtract 1, 'day'

    forward: ->
      @base_date = @base_date.clone().add 1, 'day'

    startDragging: (data) ->
      @dragging_timelog = data.timelineable
      @dragging_handle = data.handle

    stepHovered: (data) ->
      return unless @dragging_timelog and @dragging_handle

      @dragging_timelog[@dragging_handle] = data.step.clone()

    stopDragging: ->
      return unless @dragging_timelog

      @setFormTimelog @dragging_timelog
      @dragging_timelog = null

    rangeSelected: (@range) ->
      if @form_timelog
        @form_timelog.start = @range.start
        @form_timelog.finish = @range.finish

    newTimelogWithRange: (params) ->
      if @range
        params.start = @range.start
        params.finish = @range.finish

      @newTimelog params

    loadTimelogs: ->
      @timelogs_resource ?= new TimelogsResource
      return unless @start and @finish

      @timelogs_resource.index @timelogsLoaded, { from: @start.format(), to: @finish.format() }

  watch:
    base_date:
      deep: true
      immediate: true
      handler: ->
        @start = @base_date.clone().startOf('day')
        @finish = @base_date.clone().endOf('day')
        @loadTimelogs()

  computed:
    all_timelogs: ->
      return @timelogs unless @form_timelog and @form_timelog.isNewRecord()

      [@form_timelog].concat @timelogs
</script>
