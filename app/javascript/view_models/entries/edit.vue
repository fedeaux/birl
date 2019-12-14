<template lang="pug">
.entity-edit.entry-edit.default-container
  entries-form(v-model='entry'
               v-if='entry'
               @save='saveEntry()'
               @cancel='entryDone()')
</template>

<script lang="coffee">

import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
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

  computed:
    entry_id: ->
      @$route.params.id

  mounted: ->
    @entries_resource = new EntriesResource
    @loadEntry()
</script>
