import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'
import <%= entity_name %> from '../../models/<%= underscore_name %>'

export default
  props:
    context:
      default: -> {}

    parent_<%= plural_underscore_name %>: null

  data: ->
    <%= plural_underscore_name %>: null
    form_<%= underscore_name %>: null

  methods:
    <%= lowercase_entity_name %>Added: (index, <%= lowercase_entity_name %>) ->
      # console.log '<%= lowercase_entity_name %>Added', index, <%= lowercase_entity_name %>

    get<%= entity_name %>: (<%= underscore_name %>_id) ->
      index = @<%= lowercase_entity_name %>Index <%= lowercase_entity_name %>_id
      return null if index == -1
      @<%= plural_underscore_name %>[index]

    edit<%= entity_name %>: (data) ->
      @setForm<%= entity_name %> data.<%= underscore_name %>

    destroy<%= entity_name %>: (data) ->
      @<%= plural_underscore_name %>_resource.destroy data.<%= underscore_name %>, @<%= lowercase_entity_name %>Removed

    load<%= plural_entity_name %>: ->
      @<%= plural_underscore_name %>_resource ?= new <%= plural_entity_name %>Resource

      if @parent_<%= plural_underscore_name %>
        @<%= plural_lowercase_entity_name %>Loaded <%= plural_underscore_name %>: @parent_<%= plural_underscore_name %>
        return

      @<%= plural_underscore_name %>_resource.index @<%= plural_lowercase_entity_name %>Loaded, @context

    <%= plural_lowercase_entity_name %>Loaded: (response) ->
      @<%= plural_underscore_name %> = response.<%= plural_underscore_name %>

    new<%= entity_name %>: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setForm<%= entity_name %> new <%= entity_name %> final_params

    setForm<%= entity_name %>: (@form_<%= underscore_name %>) ->
      @form_<%= underscore_name %>

    clearForm<%= entity_name %>: ->
      @setForm<%= entity_name %> null

    <%= lowercase_entity_name %>Index: (<%= underscore_name %>_id) ->
      for index, <%= underscore_name %> of @<%= plural_underscore_name %>
        return index if <%= underscore_name %>.id == <%= underscore_name %>_id

      -1

    saveForm<%= entity_name %>: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @<%= lowercase_entity_name %>Saved(data)
          custom_callback(data)

        @<%= plural_underscore_name %>_resource.save @form_<%= underscore_name %>, callback
        return

      @<%= plural_underscore_name %>_resource.save @form_<%= underscore_name %>, @<%= lowercase_entity_name %>Saved

    add<%= entity_name %>: (<%= underscore_name %>) ->
      index = @<%= lowercase_entity_name %>Index <%= underscore_name %>.id

      if index == -1
        @<%= plural_underscore_name %>.unshift <%= underscore_name %>
        index = 0

      else
        Vue.set @<%= plural_underscore_name %>, index, <%= underscore_name %>

      @<%= lowercase_entity_name %>Added index, <%= underscore_name %>

    <%= lowercase_entity_name %>Saved: (data) ->
      @add<%= entity_name %> data.<%= underscore_name %>
      @clearForm<%= entity_name %>()

    <%= lowercase_entity_name %>Removed: (data) ->
      index = @<%= lowercase_entity_name %>Index data.<%= underscore_name %>.id
      return if index == -1
      @<%= plural_underscore_name %>.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @load<%= plural_entity_name %>()
