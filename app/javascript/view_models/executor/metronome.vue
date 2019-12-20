<template lang="pug">
  .executor-metronome
    .executor-metronome-animation(:class='position')
      .executor-metronome-animation-label
        | {{ actual_bpm }}

    .executor-metronome-actions
      .executor-metronome-action(@click='minus5p') -5%
      .executor-metronome-action(@click='minus1') -1
      .executor-metronome-action(v-if='bpm != actual_bpm' @click='reset')
        i.refresh.icon
      .executor-metronome-action(@click='toogleSound')
        i.volume.off.icon(v-if='sound')
        i.volume.up.icon(v-else)

      .executor-metronome-action(@click='plus1') +1
      .executor-metronome-action(@click='plus5p') +5%

</template>

<script lang="coffee">
export default
  props: ['bpm']

  data: ->
    actual_bpm: null
    sound: true
    position: 'left'

  methods:
    toogleSound: ->
      @sound = !@sound

    reset: ->
      @actual_bpm = @bpm

    start: ->
      @stop()
      period = 60000/@actual_bpm
      @tick()
      @metronome = setInterval @tick, period

    stop: ->
      clearInterval @metronome

    tick: ->
      @position = @position == 'left' and 'right' or 'left'
      return unless @sound
      Global.player.play 'tick'

    minus5p: ->
      @actual_bpm = Math.floor @actual_bpm * .95

    plus5p: ->
      @actual_bpm = Math.floor @actual_bpm * 1.05

    minus1: ->
      @actual_bpm -= 1

    plus1: ->
      @actual_bpm += 1

  beforeDestroy: ->
    @stop()

  watch:
    actual_bpm: ->
      @start()

    bpm:
      immediate: true
      handler: ->
        @reset()

</script>
