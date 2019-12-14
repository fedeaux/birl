<template lang="pug">
.entity-edit.<%= underscore_name %>-edit.default-container
  <%= plural_underscore_name %>-form(v-model='<%= underscore_name %>'
  <%= plural_underscore_name_as_spaces %>      v-if='<%= underscore_name %>'
  <%= plural_underscore_name_as_spaces %>      @save='save<%= entity_name %>()'
  <%= plural_underscore_name_as_spaces %>      @cancel='<%= underscore_name %>Done()')
</template>

<script lang="coffee">

import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'
import <%= entity_name %> from '../../models/<%= underscore_name %>'

export default
  data: ->
    <%= underscore_name %>: null

  methods:
    load<%= entity_name %>: ->
      @<%= plural_underscore_name %>_resource.get @<%= underscore_name %>_id, @<%= underscore_name %>Loaded

    <%= underscore_name %>Loaded: (response) ->
      @<%= underscore_name %> = response.<%= underscore_name %>

    save<%= entity_name %>: ->
      @<%= plural_underscore_name %>_resource.save @<%= underscore_name %>, @<%= underscore_name %>Done

    <%= underscore_name %>Done: ->
      @$router.push @<%= underscore_name %>.path()

  computed:
    <%= underscore_name %>_id: ->
      @$route.params.id

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource
    @load<%= entity_name %>()
</script>
