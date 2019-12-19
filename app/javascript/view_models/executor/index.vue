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

  .executor-label(:class='"executor-label-"+state' v-if='time_based || state == "finished"')
    template(v-if='state == "idle"' @click='start')
    template(v-else-if='state == "countdown"') Prepare...
    template(v-else-if='state == "doit" || state == "rest"')
      executor-display(:entry='entry'
                       :set_index='current_set_index'
                       :set_execution='current_set_execution'
                       :data_model='data_model'
                       :class='{ "executor-detail": state == "rest" }'
                       :default_text='display_default_text')

        template(v-if='state == "rest"')
          | Next:&nbsp;

    template(v-else-if='state == "finished"')
      | Boa, campeão! KKK
      br
      br

      .ui.three.column.centered.grid
        .column
          .ui.white.fluid.button(@click='done')
            | Vamo pro próximo

  .executor-form(v-if='(state == "doit" || state == "rest") && !time_based')
    .executor-detail(v-if='state == "rest"')
      | After rest
    entries-value-set-picker(v-model='current_set' :data_model='data_model' :in_execution='true')

  .executor-clock(v-if='state != "finished" && state != "idle"')
    .executor-clock-time(v-if='time_based || state == "rest"')
      | {{ display_time }}
    .executor-clock-time(v-else)
      i.white.arrow.alternate.circle.right.outline.icon(@click='timeout')

  .executor-actions
    i.backward.icon(@click='backward')
    i.ban.icon(@click='reset')
    i.forward.icon(@click='forward')

  .ui.two-buttons(v-if='dev_tools')
    .ui.basic.button(@click='stop') Sthap
    .ui.basic.button(@click='current_time = 1') FF
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
    current_set_index: 0
    current_set_execution: 0
    dev_tools: false
    quick_end: false

  methods:
    restDisplay: ->
      do_it_display = @doItDisplay()
      return "Next: #{do_it_display}" if do_it_display
      ''

    done: ->
      @$emit 'done'

    stop: ->
      clearInterval @timer

    finish: ->
      @state = 'finished'
      clearInterval @timer
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
          @countdown 5
        else
          @timeout()

    decreaseTimer: ->
      @current_time -= @timer_steps

      if @current_time > 6 && @quick_end
        @current_time = 4

      @timeout() if @current_time == -1

    backward: ->
      @current_time = @initial_time

    forward: ->
      @timeout()

    timeout: ->
      clearInterval @timer
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
      'Cooldown (:'

    klass: ->
      classes = ["executor-#{@state}"]
      classes.push ['executor-fullscreen'] if @fullscreen
      classes.join ' '

  beforeDestroy: ->
    clearInterval @timer
</script>
