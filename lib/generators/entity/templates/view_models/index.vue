<template lang="pug">
.entity-index.<%= plural_underscore_name %>-index.default-container
  <%= plural_underscore_name %>-list(:<%= plural_underscore_name %>='<%= plural_underscore_name %>')
</template>

<script lang="coffee">
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'

export default
  data: ->
    <%= plural_underscore_name %>: null

  methods:
    load<%= plural_entity_name %>: ->
      @<%= plural_underscore_name %>_resource.index @<%= plural_underscore_name %>Loaded

    <%= plural_underscore_name %>Loaded: (response) ->
      @<%= plural_underscore_name %> = response.<%= plural_underscore_name %>

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource
    @load<%= plural_entity_name %>()
</script>
