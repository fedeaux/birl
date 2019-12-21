<template lang="pug">
.entity-show-wrapper.<%= plural_dash_name %>-show-wrapper.default-container(v-if='<%= underscore_name %>')
  .entity-show.<%= plural_dash_name %>-show
    <%= plural_underscore_name %>-display(:<%= underscore_name %>='<%= underscore_name %>')
      router-link.entity-show-header-actions(:to='<%= underscore_name %>.editPath()')
        i.edit.icon

<%= sub_template('Body', '//-') %>
</template>

<script lang="coffee">
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'

export default
  props:
    parent_<%= underscore_name %>: null

  data: ->
    <%= underscore_name %>: null
    <%= underscore_name %>_id: null

  methods:
    load<%= entity_name %>: ->
      @<%= plural_underscore_name %>_resource.get @<%= underscore_name %>_id, @<%= underscore_name %>Loaded

    <%= underscore_name %>Loaded: (response) ->
      @<%= underscore_name %> = response.<%= underscore_name %>

<%= sub_template('Methods', '#', 4) %>

  mounted: ->
    @<%= underscore_name %> = @parent_<%= underscore_name %> if @parent_<%= underscore_name %>
<%= sub_template('Mounted', '#', 4) %>

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @<%= plural_underscore_name %>_resource ?= new <%= plural_entity_name %>Resource
        @<%= underscore_name %>_id = parseInt @$route.params.id
        @load<%= entity_name %>()
</script>
