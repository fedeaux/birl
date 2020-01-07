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
    add_new: 'before'

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
      @entries_resource ?= new EntriesResource

      if @parent_entries
        @entriesLoaded entries: @parent_entries
        return

      @entries_resource.index @entriesLoaded, @context

    entriesLoaded: (response) ->
      @entries = response.entries

    buildEntry: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Entry final_params

    newEntry: (params = {}) ->
      @setFormEntry @buildEntry params

    setFormEntry: (@form_entry) ->
      @form_entry

    clearFormEntry: ->
      @setFormEntry null

    entryIndex: (entry_id) ->
      for index, entry of @entries
        return index if entry.id == entry_id

      -1

    saveEntry: (entry, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @entrySaved(data)
          custom_callback(data)

        @entries_resource.save entry, callback
        return

      @entries_resource.save entry, @entrySaved

    saveFormEntry: (custom_callback = false) ->
      @saveEntry @form_entry, custom_callback

    createEntry: (attributes, custom_callback = false) ->
      @saveEntry @buildEntry(attributes), custom_callback

    addEntry: (entry) ->
      index = @entryIndex entry.id

      if index == -1
        if @add_new == 'before'
          @entries.unshift entry
          index = 0
        else
          @entries.push entry
          index = @entries.length - 1

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

  watch:
    context:
      immediate: true
      handler: ->
        @loadEntries()
