<template lang="pug">
.entity-manager.entries-manager.default-container
  entries-generator(:context='context'
                    :data_model='data_model'
                    :entries='entries'
                    ref='entries_generator')

  .entity-manager-form(v-if='form_entry')
    entries-form(v-model='form_entry'
                 :data_model='data_model'
                 :actions='actions.form'
                 @save='saveFormEntry()'
                 @cancel='clearFormEntry()')

  .entity-manager-list(v-else)
    .entity-manager-list-header(v-if='actions && actions.add')
      #new-entry-button.ui.primary.top.attached.fluid.small.icon.button(@click='newEntry')
        i.plus.icon
        |  Add Entry

    entries-list(:entries='entries'
                 :allow_actions='actions.list_actions'
                 @edit='editEntry($event)'
                 @destroy='destroyEntry($event)')
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'
import EntryValueSet from '../../models/entry_value_set'

export default
  props:
    actions:
      default: ->
        {
          list_actions: true,
          add: true,
          form: {
            save: true,
            cancel: true
          }
        }

    context:
      default: -> {}

    parent_entries: null
    data_model:
      default: -> {}

  data: ->
    entries: null
    form_entry: null

  methods:
    entrySetUpdated: (data) ->
      Vue.set @form_entry.value.sets, data.index, new EntryValueSet data.set

    entryAddSet: ->
      @form_entry.value.sets.push @form_entry.value.newSet @data_model

    editEntry: (data) ->
      @setFormEntry data.entry

    destroyEntry: (data) ->
      @entries_resource.destroy data.entry, @entryRemoved

    loadEntries: ->
      @entries_resource.index @entriesLoaded, @context

    entriesLoaded: (response) ->
      @entries = response.entries

    newEntry: ->
      @setFormEntry @$refs.entries_generator.generate()

    populateFormEntry: ->
      @setFormEntry @$refs.entries_generator.populate @form_entry

    setFormEntry: (@form_entry) ->
      @form_entry

    clearFormEntry: ->
      @setFormEntry null

    entryIndex: (entry_id) ->
      for index, entry of @entries
        return index if entry.id == entry_id

      -1

    saveFormEntry: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @entrySaved(data)
          custom_callback(data)

        @entries_resource.save @form_entry, callback
        return

      @entries_resource.save @form_entry, @entrySaved

    addEntry: (entry) ->
      index = @entryIndex entry.id

      if index == -1
        @entries.unshift entry
        return

      Vue.set @entries, index, entry

    entrySaved: (data) ->
      @addEntry data.entry
      @clearFormEntry()

    entryRemoved: (data) ->
      index = @entryIndex data.entry.id
      return if index == -1
      @entries.splice index, 1

  mounted: ->
    @entries_resource = new EntriesResource

    if @parent_entries
      @entries = @parent_entries
      return

    unless @context
      @loadEntries()

  watch:
    context:
      immediate: true
      handler: ->
        @entries_resource ?= new EntriesResource
        @loadEntries()
</script>
