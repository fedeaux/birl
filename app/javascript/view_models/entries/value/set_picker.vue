<template lang="pug">
.sets-picker-set
  .sets-picker-set-dimension(v-for='dimension in progressable_dimensions' :class='classForDimension(dimension)')
    .sets-picker-set-dimension-name {{ dimension.name }}

    .ui.icon.basic.small.circular.button(@click='increase(dimension)')
      i.up.angle.icon

    .ui.input
      input(type='text' v-model='set[dimension.name]' @input='changed')

    .ui.icon.basic.small.circular.button(@click='decrease(dimension)')
      i.down.angle.icon

  .ui.icon.red.tiny.circular.button.sets-remover(@click='removeSet()' v-if='!in_execution')
    i.minus.icon
</template>

<script lang="coffee">
  export default
    props:
      data_model: {}
      value: null
      in_execution: false

    data: ->
      set: null

    methods:
      changed: ->
        @$emit 'input', @set

      removeSet: ->
        @$emit 'remove'

      increase: (dimension) ->
        value = parseInt @set[dimension.name]
        Vue.set @set, dimension.name, value and value + 1 or 1
        @changed()

      decrease: (dimension) ->
        value = parseInt @set[dimension.name]
        Vue.set @set, dimension.name, value and value - 1 or 0
        @changed()

      classForDimension: (dimension) ->
        "sets-picker-set-dimension-#{dimension}"

    computed:
      progressable_dimensions: ->
        dimension for dimension in @data_model.dimensions when dimension.name != 'execution' && (!@in_execution || dimension.name != 'mult')

    watch:
      value:
        immediate: true
        handler: ->
          if @value
            @set = JSON.parse JSON.stringify @value
          else
            @set = {}
</script>
