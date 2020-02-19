<template lang="pug">
.entity-timeline.timelogs-timeline.header-contents-footer
  .header-contents-footer-header
    timelogs-timer(v-model='form_timelog'
                   @cancel='clearFormTimelog()'
                   @save='saveFormTimelog()'
                   @new='newTimelogWithRange')

  .header-contents-footer-contents
    timeline-day(v-if='timelogs'
                 :timelineables='all_timelogs'
                 @edit='editTimelog($event)'
                 @destroy='destroyTimelog($event)'
                 @rangeSelected='rangeSelected')
</template>

<script lang="coffee">
import TimelogsManagerMixin from '../../mixins/timelogs/manager'

export default
  mixins: [TimelogsManagerMixin]

  data: ->
    range: false

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

  computed:
    all_timelogs: ->
      return @timelogs unless @form_timelog

      [@form_timelog].concat @timelogs
</script>
