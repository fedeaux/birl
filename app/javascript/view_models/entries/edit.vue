<template lang="pug">
.entity-edit.entry-edit.default-container
  .entity-display
    .entity-display-main Edit Entry

  entries-form(v-model='entry'
               v-if='entry'
               :data_model='entry.data_model'
               @save='saveEntry()'
               @cancel='entryDone()')
</template>

<script lang="coffee">

import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  props:
    entry_id:
      default: null

  data: ->
    entry: null

  methods:
    loadEntry: ->
      @entries_resource.get @entry_id, @entryLoaded

    entryLoaded: (response) ->
      @entry = response.entry

    saveEntry: ->
      @entries_resource.save @entry, @entryDone

    entryDone: ->
      @$router.push @entry.path()

  mounted: ->
    @entries_resource = new EntriesResource
    @loadEntry()
</script>
