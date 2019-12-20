<template lang="pug">
.sets-picker-set(v-if='show' :class='{ "sets-picker-set-global": global }')
  .sets-picker-set-title(v-if='global') Global
  .sets-picker-set-dimension(v-for='dimension in progressable_dimensions' :class='classForDimension(dimension)')
    .sets-picker-set-dimension-name {{ dimension.name }}

    .ui.icon.basic.small.circular.button(@click='increase(dimension)')
      i.up.angle.icon

    .ui.input
      input(type='text' v-model='set[dimension.name]' @input='changed' :disabled='dimension.options.uneditable')

    .ui.icon.basic.small.circular.button(@click='decrease(dimension)')
      i.down.angle.icon

  .ui.icon.red.tiny.circular.button.sets-remover(@click='removeSet()' v-if='show_remove')
    i.minus.icon
</template>

<script lang="coffee">
  export default
    props:
      data_model: {}
      value: null
      in_execution: false
      global: false

    data: ->
      set: null

    methods:
      changed: ->
        @$emit 'input', @set

      removeSet: ->
        @$emit 'remove'

      increase: (dimension) ->
        return if dimension.options.uneditable
        value = parseInt @set[dimension.name]
        Vue.set @set, dimension.name, value and value + 1 or 1
        @changed()

      decrease: (dimension) ->
        return if dimension.options.uneditable
        value = parseInt @set[dimension.name]
        Vue.set @set, dimension.name, value and value - 1 or 0
        @changed()

      classForDimension: (dimension) ->
        klass = "sets-picker-set-dimension-#{dimension.name}"
        klass += ' sets-picker-set-dimension-uneditable' if dimension.options.uneditable
        klass

      progressableDimensions: (dimensions) ->
        dimension for dimension in dimensions when dimension.name != 'execution' && (!@in_execution || dimension.name != 'mult')

    computed:
      progressable_dimensions: ->
        return @progressableDimensions @data_model.dimensions unless @global
        @progressableDimensions @data_model.global_dimensions

      show_remove: ->
        !@in_execution && !@global

      show: ->
        !@global || @data_model.global_dimensions

    watch:
      value:
        immediate: true
        handler: ->
          if @value
            @set = JSON.parse JSON.stringify @value
          else
            @set = {}
</script>
