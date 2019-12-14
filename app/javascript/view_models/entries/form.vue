<template lang="pug">
.entity-form-wrapper.entries-form-wrapper.default-container(v-if='entry')
  .entity-form.entries-form
    .ui.form
      .field
        label Repetitions
        component(v-model='entry.values' :is='picker_component_name')

      .field
        label Observations
        input(type='text' v-model='entry.observations')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  model:
    prop: 'original_entry'

  props:
    original_entry: null
    progression_type: null

  data: ->
    entry: null

  methods:
    save: ->
      @$emit 'input', @entry
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  computed:
    picker_component_name: ->
      return 'input' unless @progression_type in ['repetitions', 'treadmill']
      "entries-form-#{@progression_type}-picker"

  watch:
    original_entry:
      immediate: true
      deep: true
      handler: ->
        if @original_entry
          @entry = @original_entry.clone()
        else
          @entry = null
</script>
