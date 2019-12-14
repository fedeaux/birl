<template lang="pug">
.entity-show-wrapper.entries-show-wrapper.default-container(v-if='entry')
  .entity-show.entries-show
    entries-display(:entry='entry')
      router-link.entity-show-header-actions(:to='entry.editPath()')
        i.edit.icon
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'

export default
  props:
    parent_entry: null

  data: ->
    entry: null
    entry_id: null

  methods:
    loadEntry: ->
      @entries_resource.get @entry_id, @entryLoaded

    entryLoaded: (response) ->
      @entry = response.entry

  mounted: ->
    if @parent_entry
      @entry = @parent_entry
      return

    @entries_resource = new EntriesResource
    @entry_id = @$route.params.id
    @loadEntry()
</script>
