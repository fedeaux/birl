<template lang="pug">
.sets-picker(v-if='data_model && data_model.dimensions')
  entries-value-set-picker(v-if='sets'
                           v-for='(set, index) in sets'
                           v-model='sets[index]'
                           :key='index'
                           :data_model='data_model'
                           @remove='removeSet(index)'
                           @input='changed()')

  .ui.icon.primary.small.circular.button.sets-adder(@click='addSet')
    i.plus.icon
</template>

<script lang="coffee">
  import EntryValueSet from '../../../models/entry_value_set'

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
        EntryValueSet.fromDataModel @data_model

      removeSet: (index) ->
        @sets.splice index, 1
        @changed()

    watch:
      value:
        immediate: true
        handler: ->
          if @value
            @sets = JSON.parse JSON.stringify @value
          else
            @sets = []
</script>
