<template lang="pug">
.executor(v-if='entry && entry.value && entry.value.sets' :class='klass')
  executor-counter(v-if='state != "finished"'
                   :sets_count='entry.value.sets.length'
                   :current_set_target_executions='current_set_target_executions'
                   :current_set_index='current_set_index'
                   :current_set_execution='current_set_execution'
                   :main_title='main_title'
                   ref='counter'
  )

  .executor-components
    .executor-label(:class='"executor-label-"+state')
      template(v-if='state == "idle"' @click='start')
      template(v-else-if='state == "doit" || state == "rest" || state == "countdown"')
        executor-display(:entry='entry'
                         :set_index='current_set_index'
                         :set_execution='current_set_execution'
                         :data_model='data_model'
                         :class='{ "executor-detail": state == "rest" || state == "countdown" }'
                         :default_text='display_default_text')

          template(v-if='state == "countdown"')
            | First:&nbsp;

          template(v-if='state == "rest"')
            | Next:&nbsp;

      template(v-else-if='state == "finished"')
        | Boa, campeão! KKK
        br
        br

        .ui.three.column.centered.grid
          .column
            .ui.white.fluid.button(@click='done')
              | Próximo
          .column
            .ui.white.fluid.button(@click='addSet')
              | Quero mais

    executor-metronome(v-if='bpm && state == "doit"' :bpm='bpm')

    .executor-form(v-if='(state == "doit" || state == "rest") && editable_set')
      .executor-detail(v-if='state == "rest"')
        | After rest
      entries-value-set-picker(v-if="!bpm"
                               v-model='current_set'
                               :data_model='data_model'
                               :in_execution='true')

    .executor-clock(v-if='state != "finished" && state != "idle"')
      .executor-clock-time(v-if='time_based || state == "rest"')
        | {{ display_time }}
      .executor-main-action(v-else)
        i.white.arrow.alternate.circle.right.outline.icon(@click='timeout')

  .executor-actions
    .executor-actions-center
      i.backward.icon(@click='backward')
      i.ban.icon(@click='reset')
      i.forward.icon(@click='forward')

    .executor-actions-right
      executor-audio-controls

  .ui.two-buttons.executor-dev-tools(v-if='dev_tools')
    .ui.basic.button(@click='stopTimer') Sthap
    .ui.basic.button(@click='current_time = 1') FF
    .ui.basic.button(@click='tick()') tick
</template>

<script lang="coffee">

export default
  props:
    data_model: null

    entry:
      required: true

    main_title: false

    timer_steps:
      default: 1

  data: ->
    state: 'idle'
    current_time: 0
    initial_time: 0
    pre_time: 3
    current_set_index: 0
    current_set_execution: 0
    dev_tools: false
    quick_end: false

  methods:
    addSet: ->
      @$emit 'entryAddSet'
      @state = 'doit'
      @findNextState()

    restDisplay: ->
      do_it_display = @doItDisplay()
      return "Next: #{do_it_display}" if do_it_display
      ''

    done: ->
      @$emit 'done'

    stopTimer: ->
      clearInterval @timer

    finish: ->
      @state = 'finished'
      @stopTimer()
      @current_time = 0

    reset: ->
      Object.assign @$data, @$options.data()

    countdown: (time) ->
      # console.log "#{@state} for #{time} seconds"
      @current_time = time
      @initial_time = time
      @timer = setInterval @decreaseTimer, @timer_steps * 1000

      @$nextTick =>
        return unless @state == 'doit' && @$refs.counter
        @$refs.counter.animate (@initial_time + 1) * 1000

    start: ->
      @state = 'countdown'
      @current_set_index = 0
      @current_set_execution = 1

      @$nextTick =>
        if @current_set.time
          @countdown @pre_time
        else
          @timeout()

    decreaseTimer: ->
      @current_time -= @timer_steps

      if @current_time > 6 && @quick_end
        @current_time = 4

      @timeout() if @current_time == -1
      @almostThere() if @current_time == 1

    almostThere: ->
      return unless @audio_schema
      state = @state
      state = 'rest' if @state == 'countdown'
      Global.player.event "#{state}_finished"

    backward: ->
      @current_time = @initial_time

    forward: ->
      @timeout()

    timeout: ->
      @stopTimer()
      @findNextState()

    findNextState: ->
      if @state == 'countdown' || @state == 'rest'
        @state = 'doit'

        if @current_set.time
          @countdown parseInt @current_set.time

      else if @state == 'doit'
        # I was doing. There are three scenarios:
        # 1. I need to "pause" and repeat this set, because I didnt do all "mult"s
        # 2. I need to "rest" and go to the next set
        # 3. All sets are over

        @state = 'rest'

        # console.log '@current_set_execution', @current_set_execution
        # console.log '@current_set_target_executions', @current_set_target_executions

        if @current_set_execution < @current_set_target_executions
          @countdown parseInt @current_set.pause || @current_set.rest
          @current_set_execution += 1

        else if @entry.value.sets[@current_set_index + 1]
          @countdown parseInt @current_set.rest || @current_set.pause
          @current_set_execution = 1
          @current_set_index += 1

          @$nextTick =>
            @$refs.counter.reset()

        else
          @finish()

  computed:
    bpm: ->
      return null unless @current_set
      return @current_set.bpm if @current_set.bpm
      Math.floor(@current_set.bpmm * @entry.value.global.bpm) if @current_set.bpmm

    editable_set: ->
      !@time_based

    time_based: ->
      @current_set && @current_set.time

    fullscreen: ->
      @state != 'idle'

    current_set:
      get: ->
        return null unless @entry && @entry.value && @entry.value.sets
        @entry.value.sets[@current_set_index]

      set: (set) ->
        @$emit 'entrySetUpdated', { index: @current_set_index, set: set }

    current_set_target_executions: ->
      return null unless @current_set
      @current_set.numberOfExecutions()

    display_time: ->
      time = Math.ceil(@current_time)
      minutes = Math.floor(time / 60)
      seconds = time % 60

      minutes = "0#{minutes}" if minutes < 10
      seconds = "0#{seconds}" if seconds < 10

      "#{minutes}:#{seconds}"

    display_default_text: ->
      return 'Just do it' if @state == 'doit'
      return 'Prepare...' if @state == 'countdown'
      'Cooldown (:'

    klass: ->
      classes = ["executor-#{@state}"]
      classes.push ['executor-fullscreen'] if @fullscreen
      classes.join ' '

  beforeDestroy: ->
    @stopTimer()

</script>
