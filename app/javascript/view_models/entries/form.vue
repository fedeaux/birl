<template lang="pug">
.entity-form-wrapper.entries-form-wrapper.default-container(v-if='entry')
  .entity-form.entries-form
    .ui.form
      .field
        entries-value-picker(v-model='entry.value' :data_model='data_model')

      .field
        label Observations
        input(type='text' v-model='entry.observations')

      .field.ui.fluid.buttons(v-if='actions')
        .ui.primary.button(@click='save()' v-if='actions.save') Save
        .ui.basic.button(@click='cancel()' v-if='actions.cancel') Cancel
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  model:
    prop: 'original_entry'

  props:
    actions:
      default: ->
        {
          save: true,
          cancel: true
        }

    original_entry: null
    data_model: {}

  data: ->
    entry: null
    last_value: null

  methods:
    save: ->
      @$emit 'input', @entry
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    'entry.value':
      deep: true
      handler: ->
        new_value = @entry.signature()

        if new_value != @last_value
          @last_value = new_value
          @$emit 'input', @entry

    original_entry:
      immediate: true
      deep: true
      handler: ->
        if @original_entry
          @entry = @original_entry.clone()
        else
          @entry = null
</script>
