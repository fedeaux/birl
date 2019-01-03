<template lang="pug">
.entity-index.entries-index.default-container
  entries-list(:entries='entries')
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'

export default
  data: ->
    entries: null

  methods:
    loadEntries: ->
      @entries_resource.index @entriesLoaded

    entriesLoaded: (response) ->
      @entries = response.entries

  mounted: ->
    @entries_resource = new EntriesResource
    @loadEntries()
</script>
