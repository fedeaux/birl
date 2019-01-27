<template lang="pug">
.entity-show-wrapper.<%= plural_underscore_name %>-show-wrapper.default-container.with-footer
  .entity-show.<%= plural_underscore_name %>-show(v-if='<%= underscore_name %>')
    h1.entity-show-header
      | {{ <%= underscore_name %>.name }}

    h2.entity-show-subheader Progressions
    progressions-manager(:context='{ <%= underscore_name %>_id: <%= underscore_name %>.id }')

  shared-footer(v-if='<%= underscore_name %>')
    router-link.ui.fluid.red.basic.button(:to='<%= underscore_name %>.editPath()')
      | Edit
</template>

<script lang="coffee">
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'

export default
  data: ->
    <%= underscore_name %>: null
    <%= underscore_name %>_id: null

  methods:
    load<%= entity_name %>: ->
      @<%= plural_underscore_name %>_resource.get @<%= underscore_name %>_id, @<%= underscore_name %>Loaded

    <%= underscore_name %>Loaded: (response) ->
      @<%= underscore_name %> = response.<%= underscore_name %>

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource
    @<%= underscore_name %>_id = @$route.params.id
    @load<%= entity_name %>()
</script>
