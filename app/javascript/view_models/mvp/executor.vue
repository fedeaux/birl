<template lang="pug">
.executor(v-if='entry' :class='klass')
  .executor-label
    template(v-if='state == "idle"' @click='start')
    template(v-else-if='state == "countdown"') Prepare...
    template(v-else-if='state == "doit"')
      | {{ doitDisplay() }}
    template(v-else-if='state == "rest"')
      | {{ restDisplay() }}

  .ui.green.message(v-if='state == "finished"') Boa!

  .executor-display(v-else)
    i.play.circle.outline.icon(v-if='state == "idle"' @click='start')
    .executor-display-time(v-else)
      | {{ display_time }}

  .executor-stop(@click='reset')
    i.refresh.icon
</template>

<script lang="coffee">

export default
  props: ['entry']

  data: ->
    state: 'idle'
    time: 0
    current_set_index: 0
    current_set_execution: 0
    fullscreen: false

  methods:
    doitDisplay: ->
      'JUST DO IT'

    restDisplay: ->
      'Cool down...'

    finish: ->
      clearInterval @timer
      @time = 0
      @current_set_index = 0
      @current_set_mult = 0
      @fullscreen = false
      @state = 'finished'

    reset: ->
      @finish()
      @state = 'idle'

    countdown: (time) ->
      @time = time
      @timer = setInterval @decreaseTimer, 1000
      @fullscreen = true # shouldBeFullScreen()

    start: ->
      @state = 'countdown'
      @current_set_index = 0
      @current_set_execution = 1
      @countdown 1

    decreaseTimer: ->
      @time -= 1
      @timeout() if @time == -1

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
          @countdown parseInt @current_set.pause
        else if @entry.value.sets[@current_set_index + 1]
          @countdown parseInt @entry.value.sets[@current_set_index].rest
        else
          @finish()

      else if @state == 'rest'
        # I was either paused or resting. There are two scenarios:
        # 1. It is time for another repetition of this set
        # 2. It is time to move to the next set

        @state = 'doit'

        if @current_set_execution < @current_set_target_executions
          @current_set_execution += 1
        else
          @current_set_execution = 1
          @current_set_index += 1

        @countdown parseInt @current_set.time

  computed:
    current_set: ->
      return null unless @entry && @entry.value && @entry.value.sets
      @entry.value.sets[@current_set_index]

    current_set_target_executions: ->
      return null unless @current_set
      @current_set.numberOfExecutions()

    display_time: ->
      minutes = Math.floor(@time / 60)
      seconds = @time % 60

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
