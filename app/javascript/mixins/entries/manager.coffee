import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  props:
    context:
      default: -> {}

    parent_entries: null

  data: ->
    entries: null
    form_entry: null

  methods:
    entryAdded: (index, entry) ->
      # console.log 'entryAdded', index, entry

    getEntry: (entry_id) ->
      index = @entryIndex entry_id
      return null if index == -1
      @entries[index]

    editEntry: (data) ->
      @setFormEntry data.entry

    destroyEntry: (data) ->
      @entries_resource.destroy data.entry, @entryRemoved

    loadEntries: ->
      @entries_resource.index @entriesLoaded, @context

    entriesLoaded: (response) ->
      @entries = response.entries

    newEntry: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormEntry new Entry final_params

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
        index = 0

      else
        Vue.set @entries, index, entry

      @entryAdded index, entry

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
