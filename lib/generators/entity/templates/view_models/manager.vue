<template lang="pug">
.entity-manager.<%= plural_underscore_name %>-manager.default-container
  .entity-manager-form(v-if='form_<%= underscore_name %>')
    <%= plural_underscore_name %>-form(:original_<%= underscore_name %>='form_<%= underscore_name %>')

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

    <%= plural_underscore_name %>Loaded: (response) ->
      @<%= plural_underscore_name %> = response.<%= plural_underscore_name %>
      @$nextTick ->
        $('#new-<%= underscore_name %>-button').click()

    new<%= entity_name %>: ->
      @setForm<%= entity_name %> new <%= entity_name %>(@context)

    setForm<%= entity_name %>: (@form_<%= underscore_name %>) ->

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource
    @load<%= plural_entity_name %>()
</script>
