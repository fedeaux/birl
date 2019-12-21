<template lang="pug">
.data-models-value-picker-item
  sui-checkbox(:label="dimension" toggle v-model="selected")
</template>

<script lang="coffee">
  import EntryValueSet from '../../../models/entry_value_set'

  export default
    props:
      dimension: {}
      initial_value: false

    data: ->
      selected: false

    watch:
      selected: ->
        @$emit 'input', { selected: @selected, dimension: @dimension }

    mounted: ->
      @selected = @initial_value

</script>
