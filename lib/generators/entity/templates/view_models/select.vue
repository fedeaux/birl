<template lang="pug">
  sui-dropdown(:options='<%= plural_underscore_name %>_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='<%= entity_name %>'
               v-model='selected_<%= underscore_name %>_id')
</template>

<script lang="coffee">
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'

export default
  model:
    prop: '<%= underscore_name %>_id'

  props:
    <%= underscore_name %>_id: null

  data: ->
    <%= plural_underscore_name %>: null
    selected_<%= underscore_name %>_id: null

  methods:
    load<%= plural_entity_name %>: ->
      @<%= plural_underscore_name %>_resource.index @<%= plural_underscore_name %>Loaded

    <%= plural_underscore_name %>Loaded: (response) ->
      @<%= plural_underscore_name %> = response.<%= plural_underscore_name %>

    <%= underscore_name %>Index: (<%= underscore_name %>_id) ->
      for index, <%= underscore_name %> of @<%= plural_underscore_name %>
        return index if <%= underscore_name %>.id == <%= underscore_name %>_id

      -1

    get<%= entity_name %>: (<%= underscore_name %>_id) ->
      index = @<%= underscore_name %>Index <%= underscore_name %>_id
      return null if index == -1
      @<%= plural_underscore_name %>[index]

  computed:
    loading: ->
      !@<%= plural_underscore_name %>

    <%= plural_underscore_name %>_as_options: ->
      return [] unless @<%= plural_underscore_name %>
      { key: <%= underscore_name %>.id, value: <%= underscore_name %>.id, text: <%= underscore_name %>.name } for <%= underscore_name %> in @<%= plural_underscore_name %>

  watch:
    selected_<%= underscore_name %>_id: ->
      @$emit 'input', @selected_<%= underscore_name %>_id

    <%= underscore_name %>_id:
      immediate: true
      handler: ->
        return unless @<%= underscore_name %>_id
        @selected_<%= underscore_name %>_id = parseInt @<%= underscore_name %>_id

  mounted: ->
    @<%= plural_underscore_name %>_resource = new <%= plural_entity_name %>Resource
    @load<%= plural_entity_name %>()

</script>
