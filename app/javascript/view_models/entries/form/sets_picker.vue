<template lang="pug">
.sets-picker(v-if='sets')
  .sets-picker-set(v-for='(set, index) in sets')
    .sets-picker-set-dimension(v-for='(value, dimension) in set' :class='classForDimension(dimension)')
      .sets-picker-set-dimension-name {{ dimension }}

      .ui.icon.basic.small.circular.button(@click='increase(index, dimension)')
        i.up.angle.icon

      .ui.input
        input(type='text' :value='value' @input='changed')

      .ui.icon.basic.small.circular.button(@click='decrease(index, dimension)')
        i.down.angle.icon

    .ui.icon.red.tiny.circular.button.sets-remover(@click='removeSet(index)')
      i.minus.icon

  .ui.icon.primary.small.circular.button.sets-adder(@click='addSet')
    i.plus.icon
</template>

<script lang="coffee">
  export default
    props:
      data_model: {}
      value: {}

    data: ->
      sets: null

    methods:
      changed: ->
        console.log 'changed'

      addSet: ->
        @sets.push JSON.parse JSON.stringify @sets[@sets.length - 1]
        @changed()

      removeSet: (index) ->
        @sets.splice index, 1
        @changed()

      increase: (index, dimension) ->
        set = @sets[index]
        set[dimension] = parseInt(set[dimension]) + 1
        Vue.set @sets, index, set
        @changed()

      decrease: (index, dimension) ->
        set = @sets[index]
        set[dimension] = parseInt(set[dimension]) - 1
        Vue.set @sets, index, set
        @changed()

      classForDimension: (dimension) ->
        "sets-picker-set-dimension-#{dimension}"

    watch:
      value:
        immediate: true
        handler: ->
          console.log @value
          if @value && @value.sets
            @sets = @value

          else
            @sets = [
              {
                weight: 35
                reps: 10
                rest: 20
              }
              {
                weight: 30
                reps: 12
                rest: 20
              }
              {
                weight: 25
                reps: 15
                rest: 20
              }
              {
                weight: 20
                reps: 18
                rest: 0
              }
            ]

    # watch:
    #   repetitions:
    #     immediate: true
    #     handler: ->
    #       as_string = @repetitions.join '/'
    #       return if as_string == @value
    #       @$emit 'input', as_string

    #   value:
    #     immediate: true
    #     handler: ->
    #       if @value and @value.split
    #         @repetitions = @value.split '/'
    #         return

    #       @repetitions = [1, 1, 1]
</script>
