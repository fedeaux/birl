<template lang="pug">
.entity-timer-wrapper.timelogs-timer-wrapper.default-container
  .ui.form
    .fields.timer-tag-select
      .field
        tags-select(v-model='selected_tag' emit="value")

    .fields.timer-fields(v-if='state == "preparing" || state == "active"')
      .field
        inputs-time(v-model='timelog.start')

      .field
        inputs-time(v-model='timelog.finish')

      .field
        input(type='text' v-model='timelog.description')

    .fields.timer-actions(v-if='state == "active"')
      .field
        .ui.basic.button(@click='cancel()') Cancel

      .field
        template(v-if='mode == "chronometer"')
          .value {{ current_chronometer }}
        template(v-if='mode == "timer"')
          .value {{ current_timer }}

      .field
        .ui.primary.button(@click='save()') Done
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
      return if @timer_interval

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

  computed:
    state: ->
      return 'idle' unless @selected_tag and @timelog
      return 'preparing' unless @timer_interval

      'active'

    current_timer: ->
      return '--:--' unless @timelog and @timelog.start and @timelog.finish

      range = moment().range @timelog.start, @timelog.finish
      return @$options.filters.seconds @timelog.finish.diff(@timelog.start, 'seconds') unless range.contains moment()

      @$options.filters.seconds @timelog.finish.diff(moment(), 'seconds')

    chronometer: ->
      return null unless @timelog and @timelog.start and @timelog.finish
      @timelog.finish.diff @timelog.start, 'seconds'

    current_chronometer: ->
      return '--:--' unless @chronometer
      @$options.filters.seconds @chronometer

  watch:
    selected_tag:
      handler: ->
        return @$emit('cancel') unless @selected_tag

        if @timelog
          @timelog.main_tag = @selected_tag unless @timelog.main_tag == @selected_tag

        else
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
          return if @timelog.main_tag == @selected_tag

          @selected_tag = @timelog.main_tag

        else
          @timelog = null
          @selected_tag = null
</script>
