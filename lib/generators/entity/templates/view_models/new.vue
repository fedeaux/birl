<template lang="pug">
.entity-new.<%= dash_name %>-new.default-container
  .entity-display
    .entity-display-main New <%= human_name %>

  <%= plural_dash_name %>-form(v-model='<%= underscore_name %>'
               @save='save<%= entity_name %>'
               @cancel='back')
</template>

<script lang="coffee">

import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'
import <%= entity_name %> from '../../models/<%= underscore_name %>'

export default
  data: ->
    <%= underscore_name %>: new <%= entity_name %>

  methods:
    save<%= entity_name %>: ->
      @<%= plural_underscore_name %>_resource.save @<%= underscore_name %>, @saved

    saved: (data) ->
      @$router.push data.<%= underscore_name %>.path()

    back: ->
      @$router.push @<%= underscore_name %>.collectionPath()

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource
</script>
