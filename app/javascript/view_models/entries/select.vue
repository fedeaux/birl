<template lang="pug">
  sui-dropdown(:options='entries_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Entry'
               v-model='selected_entry_id')
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'

export default
  model:
    prop: 'entry_id'

  props:
    entry_id: null

  data: ->
    entries: null
    selected_entry_id: null

  methods:
    loadEntries: ->
      @entries_resource.index @entriesLoaded

    entriesLoaded: (response) ->
      @entries = response.entries

    entryIndex: (entry_id) ->
      for index, entry of @entries
        return index if entry.id == entry_id

      -1

    getEntry: (entry_id) ->
      index = @entryIndex entry_id
      return null if index == -1
      @entries[index]

  computed:
    loading: ->
      !@entries

    entries_as_options: ->
      return [] unless @entries
      { key: entry.id, value: entry.id, text: entry.name } for entry in @entries

  watch:
    selected_entry_id: ->
      @$emit 'input', @selected_entry_id

    entry_id:
      immediate: true
      handler: ->
        return unless @entry_id
        @selected_entry_id = parseInt @entry_id

  mounted: ->
    @entries_resource = new EntriesResource
    @loadEntries()

</script>
