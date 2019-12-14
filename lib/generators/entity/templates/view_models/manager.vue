<template lang="pug">
.entity-manager.<%= plural_underscore_name %>-manager.default-container
  .entity-manager-form(v-if='form_<%= underscore_name %>')
    <%= plural_underscore_name %>-form(v-model='form_<%= underscore_name %>'
    <%= plural_underscore_name_as_spaces %>      @save='saveForm<%= entity_name %>()'
    <%= plural_underscore_name_as_spaces %>      @cancel='clearForm<%= entity_name %>()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-<%= underscore_name %>-button.ui.primary.top.attached.fluid.small.icon.button(@click='new<%= entity_name %>')
        i.plus.icon
        |  Add

    <%= plural_underscore_name %>-list(:<%= plural_underscore_name %>='<%= plural_underscore_name %>'
    <%= plural_underscore_name_as_spaces %>      :allow_actions='true'
    <%= plural_underscore_name_as_spaces %>      @edit='edit<%= entity_name %>($event)'
    <%= plural_underscore_name_as_spaces %>      @destroy='destroy<%= entity_name %>($event)')
</template>

<script lang="coffee">
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
    edit<%= entity_name %>: (data) ->
      @setForm<%= entity_name %> data.<%= underscore_name %>

    destroy<%= entity_name %>: (data) ->
      @<%= plural_underscore_name %>_resource.destroy data.<%= underscore_name %>, @<%= lowercase_entity_name %>Removed

    load<%= plural_entity_name %>: ->
      @<%= plural_underscore_name %>_resource.index @<%= plural_underscore_name %>Loaded, @context

    <%= lowercase_plural_entity_name %>Loaded: (response) ->
      @<%= plural_underscore_name %> = response.<%= plural_underscore_name %>

    new<%= entity_name %>: ->
      @setForm<%= entity_name %> new <%= entity_name %> @context

    setForm<%= entity_name %>: (@form_<%= underscore_name %>) ->

    clearForm<%= entity_name %>: ->
      @setForm<%= entity_name %> null

    <%= lowercase_entity_name %>Index: (<%= underscore_name %>_id) ->
      for index, <%= underscore_name %> of @<%= plural_underscore_name %>
        return index if <%= underscore_name %>.id == <%= underscore_name %>_id

      -1

    saveForm<%= entity_name %>: ->
      @<%= plural_underscore_name %>_resource.save @form_<%= underscore_name %>, @<%= lowercase_entity_name %>Saved

    add<%= entity_name %>: (<%= underscore_name %>) ->
      index = @<%= lowercase_entity_name %>Index <%= underscore_name %>.id

      if index == -1
        @<%= plural_underscore_name %>.push <%= underscore_name %>
        return

      Vue.set @<%= plural_underscore_name %>, index, <%= underscore_name %>

    <%= lowercase_entity_name %>Saved: (data) ->
      @add<%= entity_name %> data.<%= underscore_name %>
      @clearForm<%= entity_name %>()

    <%= lowercase_entity_name %>Removed: (data) ->
      index = @<%= underscore_name %>Index data.<%= underscore_name %>.id
      return if index == -1
      @<%= plural_underscore_name %>.splice index, 1

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource

    if @parent_<%= plural_underscore_name %>
      @<%= plural_underscore_name %> = @parent_<%= plural_underscore_name %>
      return

    @load<%= plural_entity_name %>()
</script>
