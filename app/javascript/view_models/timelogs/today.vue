<template lang="pug">
.entity-timeline.timelogs-timeline.header-contents-footer
  .header-contents-footer-header.timelogs-timeline-header
    .timelogs-timeline-header-title {{ base_date.format('ddd, MMM DD') }}

    timelogs-day-planner(:base_date='base_date'
                         @dayPlanned='loadTimelogs')

    timelogs-timer(v-model='form_timelog'
                   @cancel='clearFormTimelog()'
                   @save='saveFormTimelog()'
                   @new='newTimelogWithRange')

  .header-contents-footer-contents
    timeline-day(v-if='timelogs'
                 :timelineables='all_timelogs'
                 :start='start'
                 :finish='finish'
                 @edit='editTimelog($event)'
                 @destroy='destroyTimelog($event)'
                 @rangeSelected='rangeSelected')
</template>

<script lang="coffee">
import TimelogsManagerMixin from '../../mixins/timelogs/manager'
import TimelogsResource from '../../resources/timelogs_resource'

export default
  mixins: [TimelogsManagerMixin]

  props:
    base_date:
      default: -> moment()

  data: ->
    range: false
    start: @base_date.clone().startOf('day')
    finish: @base_date.clone().endOf('day')

  methods:
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
      @timelogs_resource.index @timelogsLoaded, { from: @start.format(), to: @finish.format() }

  computed:
    all_timelogs: ->
      return @timelogs unless @form_timelog and @form_timelog.isNewRecord()

      [@form_timelog].concat @timelogs
</script>
