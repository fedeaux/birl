<template lang="pug">
  shared-modal(v-if='form_entry' title='New Entry')
    entries-form(v-model='form_entry'
                   @save='saveFormEntry()'
                   @cancel='clearFormEntry()')

  sui-dropdown(:options='entries_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Entry'
               v-else
               v-model='selected_entry_id')

</template>

<script lang="coffee">
import EntriesManagerMixin from '../../mixins/entries/manager'

export default
  mixins: [EntriesManagerMixin]

  model:
    prop: 'entry_id'

  props:
    entry_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_entry_id: null

  methods:
    entryAdded: (index, entry) ->
      @selectEntry entry

    selectEntry: (entry) ->
      @selected_entry_id = parseInt entry.id

  computed:
    loading: ->
      !@entries

    entries_as_options: ->
      return [] unless @entries
      { key: entry.id, value: entry.id, text: entry.name } for entry in @entries

  watch:
    selected_entry_id: ->
      selected_entry_id = parseInt @selected_entry_id

      unless isNaN selected_entry_id
        @$emit 'input', selected_entry_id
        return

      @newEntry name: @selected_entry_id

    entry_id:
      immediate: true
      handler: ->
        return unless @entry_id
        @selected_entry_id = parseInt @entry_id

</script>
