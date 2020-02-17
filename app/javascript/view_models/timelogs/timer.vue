<template lang="pug">
.entity-timer-wrapper.timelogs-timer-wrapper.default-container
  .ui.form
    .fields
      template(v-if='state == "idle"')
        .field
          tags-select(v-model='selected_tag' emit="value")

      template(v-if='state == "preparing" || state == "active"')
        .field
          inputs-time(v-model='timelog.start')

        .field
          inputs-time(v-model='timelog.finish')

        .field
          input(type='text' v-model='timelog.description')

      template(v-if='state == "active"')
        .field
          .ui.primary.button(@click='save()') Done

        .field
          .ui.basic.button(@click='cancel()') Cancel

        .field
          .value {{ current_duration }}
</template>

<script lang="coffee">
import TimelogsResource from '../../resources/timelogs_resource'
import Timelog from '../../models/timelog'

export default
  model:
    prop: 'original_timelog'

  props:
    original_timelog: null

  data: ->
    timelog: null
    selected_tag: null
    timer_interval: null

  methods:
    start: ->
      @timer_interval = setInterval (=> @increaseTimelogFinish()), 1000

    input: ->
      @$emit 'input', @timelog

    save: ->
      @input()
      @$emit 'save'

    cancel: ->
      @selected_tag = null
      @$emit 'cancel'

    increaseTimelogFinish: ->
      if @timelog and @timelog.finish
        @timelog.finish = @timelog.finish.add 1, 'second'
        @input()

        @$forceUpdate()
        return

      clearInterval @timer_interval
      @timer_interval = null

  computed:
    state: ->
      return 'idle' unless @selected_tag and @timelog
      return 'preparing' unless @timer_interval

      'active'

    current_duration: ->
      return '--:--' unless @timelog and @timelog.start and @timelog.finish

      seconds = @timelog.finish.diff @timelog.start, 'seconds'

      hours = parseInt seconds / 3600
      seconds -= hours * 3600
      minutes = parseInt seconds / 60
      seconds -= minutes * 60

      parts = []

      if hours > 0
        parts.push "#{hours}h"

      if minutes > 0
        parts.push "#{minutes}m"

      if seconds > 0
        parts.push "#{seconds}s"

      return '--:--' unless parts.length > 0

      parts.join('')

  watch:
    selected_tag:
      handler: ->
        return @$emit('cancel') unless @selected_tag

        @$emit('new', main_tag: @selected_tag, start: moment(), finish: moment())
        @start()

    original_timelog:
      immediate: true
      deep: true
      handler: ->
        if @original_timelog
          @timelog = @original_timelog.clone()
        else
          @timelog = null
</script>
