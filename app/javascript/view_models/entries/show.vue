<template lang="pug">
.entity-show-wrapper.entries-show-wrapper.default-container
  .entity-show.entries-show(v-if='entry')
    h1.entity-show-header
      | {{ entry.name }}
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'

export default
  data: ->
    entry: null
    entry_id: null

  methods:
    loadEntry: ->
      @entries_resource.get @entry_id, @entryLoaded

    entryLoaded: (response) ->
      @entry = response.entry

  mounted: ->
    @entries_resource = new EntriesResource
    @entry_id = @$route.params.id
    @loadEntry()
</script>
