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
    current_set_set: 0
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
      @current_set_set = 0
      @fullscreen = false
      @state = 'finished'

    reset: ->
      @finish()
      @state = 'idle'

    countdown: (time) ->
      @time = time
      @timer = setInterval @decreaseTimer, 1000
      @fullscreen = true

    start: ->
      @state = 'countdown'
      @countdown 5

    decreaseTimer: ->
      @time -= 1
      @timeout() if @time == -1

    timeout: ->
      clearInterval @timer
      @findNextState()

    findNextState: ->
      if @state == 'countdown'
        @state = 'doit'
        @countdown parseInt @entry.value.sets[@current_set_index].time

      else if @state == 'doit'
        @state = 'rest'
        sets = parseInt @entry.value.sets[@current_set_index].sets

        another_set = sets and @current_set_set < sets

        if @entry.value.sets[@current_set_index + 1] or another_set
          @countdown parseInt @entry.value.sets[@current_set_index].rest
        else
          @finish()

      else if @state == 'rest'
        @current_set_set += 1
        sets = parseInt @entry.value.sets[@current_set_index].sets

        if !sets or @current_set_set >= sets
          @current_set_index += 1
          @current_set_set = 0

        @state = 'doit'
        @countdown parseInt @entry.value.sets[@current_set_index].rest

  computed:
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
