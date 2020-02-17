<template lang="pug">
.entity-timeline.timelogs-timeline.header-contents-footer
  .header-contents-footer-header
    timelogs-timer(v-model='form_timelog'
                   @cancel='clearFormTimelog()'
                   @save='saveFormTimelog()'
                   @new='newTimelog')

  .header-contents-footer-contents
    timeline-day(v-if='timelogs'
                 :timelineables='all_timelogs')
</template>

<script lang="coffee">
import TimelogsManagerMixin from '../../mixins/timelogs/manager'

export default
  mixins: [TimelogsManagerMixin]

  computed:
    all_timelogs: ->
      return @timelogs unless @form_timelog

      [@form_timelog].concat @timelogs
</script>
