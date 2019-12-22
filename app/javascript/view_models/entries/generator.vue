<template lang="pug">
  .renderless-component
</template>

<script lang="coffee">

import Entry from '../../models/entry'

export default
  props: ['context', 'data_model', 'entries']

  methods:
    newEntry: ->
      if !@entries or @entries.length == 0
        return Entry.fromDataModelAndContext @context, @data_model

      last_entry = @entries[0]
      new Entry _.extend {}, @context, { value: last_entry.value }

    generate: ->
      @populate @newEntry()

    populate: (new_entry) ->
      if @data_model.generator
        generator = Global.egm.instantiate @data_model.generator
        return generator.generate new_entry, @entries, @data_model

      new_entry
</script>
