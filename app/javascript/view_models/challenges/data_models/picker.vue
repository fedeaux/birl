<template lang="pug">
.data-models-value-picker
  .ui.two.column.grid
    .column
      label Dimensions
      challenges-data-models-picker-item(v-for='dimension in dimensions'
                                         :dimension='dimension'
                                         :initial_value='selected_dimensions[dimension]'
                                         @input='toogleDimension')
</template>

<script lang="coffee">
  import EntryValueSet from '../../../models/entry_value_set'

  export default
    props:
      data_model: {}
      value: {}

    data: ->
      inner_value: null
      selected_dimensions: {}

    methods:
      toogleDimension: (data) ->
        @selected_dimensions[data.dimension] = data.selected
        @inner_value.dimensions = ({ name: dimension, options: {} } for dimension, selected of @selected_dimensions when selected)
        @changed()

      changed: ->
        @$emit 'input', @inner_value

    computed:
      dimensions: ->
        (dimension for dimension in Object.keys(EntryValueSet.attributes()).sort() when dimension != 'execution')

    watch:
      value:
        immediate: true
        handler: ->
          if @value and @value.dimensions
            @inner_value = JSON.parse JSON.stringify @value
          else
            @inner_value = { dimensions: [] }

          for dimension in @inner_value.dimensions
            @selected_dimensions[dimension.name] = true
</script>
