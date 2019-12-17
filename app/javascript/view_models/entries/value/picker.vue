<template lang="pug">
.entries-value-picker
  entries-value-sets-picker(v-model='inner_value.sets' :data_model='data_model' @input='changed')
</template>

<script lang="coffee">
  import EntryValue from '../../../models/entry_value'

  export default
    props:
      data_model: {}
      value: {}

    data: ->
      inner_value: null
      last_inner_value: null

    methods:
      changed: ->
        @$emit 'input', @inner_value

    watch:
      'inner_value.sets':
        deep: true
        handler: ->
          new_value = @inner_value.signature()

          if new_value != @last_inner_value
            @last_inner_value = new_value
            @changed()

      value:
        immediate: true
        handler: ->
          if @value and @value.sets
            @inner_value = @value.clone()
          else
            @inner_value = new EntryValue { sets: [], options: {} }
</script>
