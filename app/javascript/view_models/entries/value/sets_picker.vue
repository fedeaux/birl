<template lang="pug">
.sets-picker(v-if='data_model && data_model.dimensions')
  .sets-picker-set(v-for='(set, index) in sets' v-if='sets')
    .sets-picker-set-dimension(v-for='dimension in data_model.dimensions' :class='classForDimension(dimension)')
      .sets-picker-set-dimension-name {{ dimension.name }}

      .ui.icon.basic.small.circular.button(@click='increase(index, dimension)')
        i.up.angle.icon

      .ui.input
        input(type='text' v-model='sets[index][dimension.name]' @input='changed')

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
      value: null

    data: ->
      sets: null

    methods:
      changed: ->
        @$emit 'input', @sets

      addSet: ->
        @sets.push @newSet()
        @changed()

      newSet: ->
        return JSON.parse JSON.stringify @sets[@sets.length - 1] if @sets and @sets.length > 0
        set = {}

        for dimension in @data_model.dimensions
          set[dimension.name] = 1

        set

      removeSet: (index) ->
        @sets.splice index, 1
        @changed()

      increase: (index, dimension) ->
        set = @sets[index]
        value = parseInt set[dimension.name]
        set[dimension.name] = value and value + 1 or 1
        Vue.set @sets, index, set
        @changed()

      decrease: (index, dimension) ->
        set = @sets[index]
        value = parseInt set[dimension.name]
        set[dimension.name] = value and value - 1 or 0
        Vue.set @sets, index, set
        @changed()

      classForDimension: (dimension) ->
        "sets-picker-set-dimension-#{dimension}"

    watch:
      value:
        immediate: true
        handler: ->
          if @value
            @sets = JSON.parse JSON.stringify @value
          else
            @sets = []
</script>
