<template lang="pug">
.entity-manager.<%= plural_underscore_name %>-manager.default-container
  .entity-manager-form(v-if='form_<%= underscore_name %>')
    <%= plural_underscore_name %>-form(v-model='form_<%= underscore_name %>' @save='saveForm<%= entity_name %>()')

  .entity-manager-list(v-else)
    #new-<%= underscore_name %>-button.ui.primary.small.icon.button(@click='new<%= entity_name %>')
      i.add.icon
      | add
    <%= plural_underscore_name %>-list(:<%= plural_underscore_name %>='<%= plural_underscore_name %>')
</template>

<script lang="coffee">
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'
import <%= entity_name %> from '../../models/<%= underscore_name %>'

export default
  props:
    context:
      default: -> {}

  data: ->
    <%= plural_underscore_name %>: null
    form_<%= underscore_name %>: null

  methods:
    load<%= plural_entity_name %>: ->
      @<%= plural_underscore_name %>_resource.index @<%= plural_underscore_name %>Loaded, @context

    <%= lowercase_plural_entity_name %>Loaded: (response) ->
      @<%= plural_underscore_name %> = response.<%= plural_underscore_name %>

    new<%= entity_name %>: ->
      @setForm<%= entity_name %> new <%= entity_name %>(@context)

    setForm<%= entity_name %>: (@form_<%= underscore_name %>) ->

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

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource
    @load<%= plural_entity_name %>()
</script>
