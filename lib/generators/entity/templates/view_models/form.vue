<template lang="pug">
</template>

<script lang="coffee">

import <%= entity_name %> from '../../models/<%= underscore_name %>'
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'

export default
  props: ['<%= underscore_name %>_id']

  data: ->
    <%= underscore_name %>: null
    loading: false

  methods:
    save: ->
      # @validate =>
      @loading = true
      @<%= plural_underscore_name %>_resource.save @<%= underscore_name %>, @<%= underscore_name %>Saved

    validate: (onValid) ->
      @$validator.validateAll().then (valid) =>
        onValid() if onValid and valid

    <%= underscore_name %>Saved: (data) ->
      @set<%= entity_name %> data
      @loading = false
      @$router.push name: '<%= plural_underscore_name %>-show', params: { id: @<%= underscore_name %>.id }

    set<%= entity_name %>: (data) ->
      @<%= underscore_name %> = data.<%= underscore_name %>

    load<%= entity_name %>: ->
      @loading = true
      id = @<%= underscore_name %>_id or @<%= underscore_name %>.id
      return unless id

      @<%= plural_underscore_name %>_resource.get id, (data) =>
        @set<%= entity_name %> data
        @loading = false

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource

    if @<%= underscore_name %>_id
      @load<%= entity_name %>()
    else
      @set<%= entity_name %> <%= underscore_name %>: new <%= entity_name %>()
</script>
