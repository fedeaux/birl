<template lang="pug">
entries-manager.entries-index(:parent_entries='entries')
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
