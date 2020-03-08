import GoalEntriesResource from '../../resources/goal_entries_resource'
import GoalEntry from '../../models/goal_entry'

export default
  props:
    context:
      default: -> {}

    parent_goal_entries: null

  data: ->
    goal_entries: null
    form_goal_entry: null
    add_new: 'before'

  methods:
    goalEntryAdded: (index, goalEntry) ->
      # console.log 'goalEntryAdded', index, goalEntry

    getGoalEntry: (goal_entry_id) ->
      index = @goalEntryIndex goalEntry_id
      return null if index == -1
      @goal_entries[index]

    editGoalEntry: (data) ->
      @setFormGoalEntry data.goal_entry

    destroyGoalEntry: (data) ->
      @goal_entries_resource.destroy data.goal_entry, @goalEntryRemoved

    loadGoalEntries: ->
      @goal_entries_resource ?= new GoalEntriesResource

      if @parent_goal_entries
        @goalEntriesLoaded goal_entries: @parent_goal_entries
        return

      @goal_entries_resource.index @goalEntriesLoaded, @context

    goalEntriesLoaded: (response) ->
      @goal_entries = response.goal_entries

    buildGoalEntry: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new GoalEntry final_params

    newGoalEntry: (params = {}) ->
      @setFormGoalEntry @buildGoalEntry params

    setFormGoalEntry: (@form_goal_entry) ->
      @form_goal_entry

    clearFormGoalEntry: ->
      @setFormGoalEntry null

    goalEntryIndex: (goal_entry_id) ->
      for index, goal_entry of @goal_entries
        return index if goal_entry.id == goal_entry_id

      -1

    saveGoalEntry: (goal_entry, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @goalEntrySaved(data)
          custom_callback(data)

        @goal_entries_resource.save goal_entry, callback
        return

      @goal_entries_resource.save goal_entry, @goalEntrySaved

    saveFormGoalEntry: (custom_callback = false) ->
      @saveGoalEntry @form_goal_entry, custom_callback

    createGoalEntry: (attributes, custom_callback = false) ->
      @saveGoalEntry @buildGoalEntry(attributes), custom_callback

    addGoalEntry: (goal_entry) ->
      index = @goalEntryIndex goal_entry.id

      if index == -1
        if @add_new == 'before'
          @goal_entries.unshift goal_entry
          index = 0
        else
          @goal_entries.push goal_entry
          index = @goal_entries.length - 1

      else
        Vue.set @goal_entries, index, goal_entry

      @goalEntryAdded index, goal_entry

    goalEntrySaved: (data) ->
      @addGoalEntry data.goal_entry
      @clearFormGoalEntry()

    goalEntryRemoved: (data) ->
      index = @goalEntryIndex data.goal_entry.id
      return if index == -1
      @goal_entries.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadGoalEntries()
