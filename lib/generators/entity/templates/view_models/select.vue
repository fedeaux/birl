<template lang="pug">
  shared-modal(v-if='form_<%= underscore_name %>' title='New <%= human_name %>')
    <%= plural_dash_name %>-form(v-model='form_<%= underscore_name %>'
    <%= plural_dash_name_as_spaces %>      @save='saveForm<%= entity_name %>()'
    <%= plural_dash_name_as_spaces %>      @cancel='clearForm<%= entity_name %>()')

  sui-dropdown(:options='<%= plural_underscore_name %>_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='<%= human_name %>'
               v-else
               v-model='selected_<%= underscore_name %>_id')

</template>

<script lang="coffee">
import <%= plural_entity_name %>ManagerMixin from '../../mixins/<%= plural_underscore_name %>/manager'

export default
  mixins: [<%= plural_entity_name %>ManagerMixin]

  model:
    prop: '<%= underscore_name %>_id'

  props:
    <%= underscore_name %>_id: null
    allow_additions: true

  data: ->
    selected_<%= underscore_name %>_id: null

  methods:
    <%= lowercase_entity_name %>Added: (index, <%= lowercase_entity_name %>) ->
      @select<%= entity_name %> <%= underscore_name %>

    select<%= entity_name %>: (<%= underscore_name %>) ->
      @selected_<%= underscore_name %>_id = parseInt <%= underscore_name %>.id

  computed:
    loading: ->
      !@<%= plural_underscore_name %>

    <%= plural_underscore_name %>_as_options: ->
      return [] unless @<%= plural_underscore_name %>
      { key: <%= underscore_name %>.id, value: <%= underscore_name %>.id, text: <%= underscore_name %>.name } for <%= underscore_name %> in @<%= plural_underscore_name %>

  watch:
    selected_<%= underscore_name %>_id: ->
      selected_<%= underscore_name %>_id = parseInt @selected_<%= underscore_name %>_id

      unless isNaN selected_<%= underscore_name %>_id
        @$emit 'input', selected_<%= underscore_name %>_id
        return

      @new<%= entity_name %> name: @selected_<%= underscore_name %>_id

    <%= underscore_name %>_id:
      immediate: true
      handler: ->
        return unless @<%= underscore_name %>_id
        @selected_<%= underscore_name %>_id = parseInt @<%= underscore_name %>_id

</script>
