<template lang="pug">
.entry-reps-picker
  .entry-reps-picker-item(v-for='(repetition, index) in repetitions')
    .ui.icon.basic.small.circular.button(@click='increase(index)')
      i.up.angle.icon

    input(type='text' :value='repetition')

    .ui.icon.basic.small.circular.button(@click='decrease(index)')
      i.down.angle.icon

    .ui.icon.red.tiny.circular.button(@click='removeRepetition(index)')
      i.minus.icon

  .ui.icon.primary.small.circular.button.reps-counter(@click='addRepetition')
    i.plus.icon
</template>

<script lang="coffee">
  export default
    props:
      value: ''

    data: ->
      repetitions: [0, 0, 0]

    methods:
      addRepetition: ->
        @repetitions.push 5
        @$emit 'input', @repetitions.join '/'

      removeRepetition: (index) ->
        @repetitions.splice(index, 1)
        @$emit 'input', @repetitions.join '/'

      increase: (index) ->
        value = parseInt @repetitions[index]
        Vue.set @repetitions, index, value + 1
        @$emit 'input', @repetitions.join '/'

      decrease: (index) ->
        value = parseInt @repetitions[index]
        Vue.set @repetitions, index, value - 1
        @$emit 'input', @repetitions.join '/'

    watch:

      value:
        immediate: true
        handler: ->
          if @value and @value.split
            @repetitions = @value.split '/'
            return

          @repetitions = [0, 0, 0]
</script>
