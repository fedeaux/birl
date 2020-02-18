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
          template(v-if='mode == "chronometer"')
            .value {{ current_chronometer }}
          template(v-if='mode == "timer"')
            .value {{ current_timer }}
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
    mode: 'timer'

  methods:
    start: ->
      @timer_interval = setInterval (=> @clockTick()), 1000

    input: ->
      @$emit 'input', @timelog

    save: ->
      @input()
      @$emit 'save'

    cancel: ->
      @selected_tag = null
      @$emit 'cancel'

    clockTick: ->
      unless @timelog and @timelog.finish
        clearInterval @timer_interval
        @timer_interval = null

      if @mode == 'chronometer'
        @timelog.finish = @timelog.finish.add 1, 'second'

      @$forceUpdate()
      @input()

    secondsFormatted: (seconds) ->
      signal = seconds < 0 and '-' or ''
      seconds = Math.abs seconds

      hours = parseInt seconds / 3600
      seconds -= hours * 3600
      minutes = parseInt seconds / 60
      seconds -= minutes * 60

      parts = [signal]

      if hours > 0
        parts.push "#{hours}h"

      if minutes > 0
        parts.push "#{minutes}m"

      if seconds != 0
        parts.push "#{seconds}s"

      return '--:--' unless parts.length > 0

      parts.join('')

  computed:
    state: ->
      return 'idle' unless @selected_tag and @timelog
      return 'preparing' unless @timer_interval

      'active'

    current_timer: ->
      return '--:--' unless @timelog and @timelog.start and @timelog.finish
      @secondsFormatted @timelog.finish.diff(moment(), 'seconds')

    chronometer: ->
      return null unless @timelog and @timelog.start and @timelog.finish
      @timelog.finish.diff @timelog.start, 'seconds'

    current_chronometer: ->
      return '--:--' unless @chronometer
      @secondsFormatted @chronometer

  watch:
    selected_tag:
      handler: ->
        return @$emit('cancel') unless @selected_tag

        if @mode == 'timer'
          @$emit('new', main_tag: @selected_tag, start: moment(), finish: moment().add(1, 'hour'))

        else if @mode == 'chronometer'
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
