<template lang="pug">
.executor(v-if='entry && entry.value && entry.value.sets' :class='klass')
  mvp-executor-counter(:sets_count='entry.value.sets.length'
                       :current_set_target_executions='current_set_target_executions'
                       :current_set_index='current_set_index'
                       :current_set_execution='current_set_execution'
                       ref='counter'

  )

  .executor-label(:class='"executor-label-"+state')
    template(v-if='state == "idle"' @click='start')
    template(v-else-if='state == "countdown"') Prepare...
    template(v-else-if='state == "doit"')
      | {{ doItDisplay() }}
    template(v-else-if='state == "rest"')
      | Cool down...
      .executor-label-detail
        | {{ restDisplay() }}

    template(v-else-if='state == "finished"')
     | Boa, campeão! KKK

     .ui.basic.green.button(@click='reset')
       | Vamo pro próximo

  .executor-display
    i.play.circle.outline.icon(v-if='state == "idle"' @click='start')
    .executor-display-time(v-else)
      | {{ display_time }}

  .executor-stop(@click='reset')
    i.ban.icon

  .ui.two-buttons(v-if='dev_tools')
    .ui.basic.button(@click='stop') Sthap
    .ui.basic.button(@click='current_time = 1') FF
</template>

<script lang="coffee">

export default
  props:
    entry:
      required: true

    timer_steps:
      default: 1

  data: ->
    state: 'idle'
    current_time: 0
    initial_time: 0
    current_set_index: 0
    current_set_execution: 0
    fullscreen: false
    dev_tools: false

  methods:
    doItDisplay: ->
      options = {
        current_set_index: @current_set_index
        current_set_execution: @current_set_execution - 1
      }

      @entry.executorDisplay(options) || 'Just do it'

    restDisplay: ->
      do_it_display = @doItDisplay()
      return "Next: #{do_it_display}" if do_it_display
      ''

    stop: ->
      clearInterval @timer

    finish: ->
      @state = 'finished'
      clearInterval @timer
      @current_time = 0

    reset: ->
      # Object.assign @$data, @$options.data()

    countdown: (time) ->
      # console.log "#{@state} for #{time} seconds"
      @current_time = time
      @initial_time = time
      @timer = setInterval @decreaseTimer, @timer_steps * 1000
      @fullscreen = true # shouldBeFullScreen()

      @$nextTick =>
        return unless @state == 'doit'
        @$refs.counter.animate (@initial_time + 1) * 1000

    start: ->
      @state = 'countdown'
      @current_set_index = 0
      @current_set_execution = 1
      @countdown 1

    decreaseTimer: ->
      @current_time -= @timer_steps
      @timeout() if @current_time == -1

    timeout: ->
      clearInterval @timer
      @findNextState()

    findNextState: ->
      if @state == 'countdown'
        @state = 'doit'
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

      else if @state == 'rest'
        # I was either paused or resting. There are two scenarios:
        # 1. It is time for another repetition of this set
        # 2. It is time to move to the next set

        @state = 'doit'
        @countdown parseInt @current_set.time

  computed:
    current_set: ->
      return null unless @entry && @entry.value && @entry.value.sets
      @entry.value.sets[@current_set_index]

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

    klass: ->
      classes = ["executor-#{@state}"]
      classes.push ['executor-fullscreen'] if @fullscreen
      classes.join ' '

  beforeDestroy: ->
    clearInterval @timer
</script>
