<template lang="pug">
.entity-manager.entries-manager.default-container
  .entity-manager-form(v-if='form_entry')
    entries-form(v-model='form_entry'
                 @save='saveFormEntry()'
                 @cancel='clearFormEntry()')


  .entity-manager-list(v-else)
    #new-entry-button.ui.primary.top.attached.fluid.small.icon.button(@click='newEntry')
      | Add

    entries-list(:entries='entries' @edit='editEntry($event)' @destroy='destroyEntry($event)')
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  props:
    context:
      default: -> {}

  data: ->
    entries: -> []
    form_entry: null

  methods:
    editEntry: (data) ->
      @setFormEntry data.entry

    destroyEntry: (data) ->
      @entries_resource.destroy data.entry, @entryRemoved

    loadEntries: ->
      @entries_resource.index @entriesLoaded, @context

    entriesLoaded: (response) ->
      @entries = response.entries
      @$nextTick ->
        @newEntry()

    newEntry: ->
      last_entry = @entries[0]

      if last_entry
        @setFormEntry new Entry _.extend {}, @context, { values: last_entry.values }
        return

      @setFormEntry new Entry @context

    setFormEntry: (@form_entry) ->

    clearFormEntry: ->
      @setFormEntry null


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
      @clearFormEntry()

    entryRemoved: (data) ->
      index = @entryIndex data.entry.id
      return if index == -1
      @entries.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @entries_resource ?= new EntriesResource
        @loadEntries()
</script>
