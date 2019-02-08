<template lang="pug">
.entity-form-wrapper.entries-form-wrapper.default-container(v-if='entry')
  .entity-form.entries-form
    .ui.form
      .field
        label Value
        input(type='text' v-model='entry.values')

      .field
        .ui.primary.button(@click='save()') Save

</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  props:
    value: null

  data: ->
    entry: null

  methods:
    save: ->
      @$emit 'save'

  mounted: ->

  watch:
    original_entry:
      immediate: true
      deep: true
      handler: ->
        if @value
          @entry = @value.clone()
        else
          @entry = null

    entry:
      deep: true
      handler: ->
        @$emit 'input', @entry

</script>
