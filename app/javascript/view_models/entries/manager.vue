<template lang="pug">
.entity-manager.entries-manager.default-container
  .entity-manager-form(v-if='form_entry')
    entries-form(v-model='form_entry' @save='saveFormEntry()')

  .entity-manager-list(v-else)
    #new-entry-button.ui.primary.small.icon.button(@click='newEntry')
      i.add.icon
      | add
    entries-list(:entries='entries')
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  props:
    context:
      default: -> {}

  data: ->
    entries: null
    form_entry: null

  methods:
    loadEntries: ->
      @entries_resource.index @entriesLoaded, @context

    entriesLoaded: (response) ->
      @entries = response.entries
      @$nextTick ->
        $('#new-entry-button').click()

    newEntry: ->
      @setFormEntry new Entry(@context)

    setFormEntry: (@form_entry) ->

    entryIndex: (entry_id) ->
      for index, entry of @entries
        return index if entry.id == entry_id

      -1

    saveFormEntry: ->
      @entries_resource.save @form_entry, @entrySaved

    addEntry: (entry) ->
      index = @entryIndex entry.id

      if index == -1
        @entries.push entry
        return

      Vue.set @entries, index, entry

    entrySaved: (data) ->
      @addEntry data.entry

  mounted: ->
    @entries_resource = new EntriesResource
    @loadEntries()
</script>
