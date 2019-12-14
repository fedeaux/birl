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
      repetitions: [1, 1, 1]

    methods:
      addRepetition: ->
        @repetitions.push 5

      removeRepetition: (index) ->
        @repetitions.splice(index, 1)

      increase: (index) ->
        value = parseInt @repetitions[index]
        Vue.set @repetitions, index, value + 1

      decrease: (index) ->
        value = parseInt @repetitions[index]
        Vue.set @repetitions, index, value - 1

    watch:
      repetitions:
        immediate: true
        handler: ->
          as_string = @repetitions.join '/'
          return if as_string == @value
          @$emit 'input', as_string

      value:
        immediate: true
        handler: ->
          if @value and @value.split
            @repetitions = @value.split '/'
            return

          @repetitions = [1, 1, 1]
</script>
