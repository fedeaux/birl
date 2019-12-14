<template lang="pug">
.entity-form-wrapper.<%= plural_underscore_name %>-form-wrapper.default-container(v-if='<%= underscore_name %>')
  .entity-form.<%= plural_underscore_name %>-form
    .ui.form
<%- attributes.each do |attribute| -%>
<%-   if attribute.name != 'user' && [:string, :interger, :references, :belongs_to].include?(attribute.type) -%>
      .field
        label <%= attribute.name.titleize %>
<%-     if [:string, :interger].include? attribute.type -%>
        input(type='text' v-model='<%= underscore_name %>.<%= attribute.name %>')
<%-     elsif [:references, :belongs_to].include? attribute.type -%>
        <%= attribute.name.pluralize %>-select(v-model='<%= underscore_name %>.<%= attribute.name %>_id')
<%- end -%>

<%- end -%>
<%- end -%>
      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'
import <%= entity_name %> from '../../models/<%= underscore_name %>'

export default
  model:
    prop: 'original_<%= underscore_name %>'

  props:
    original_<%= underscore_name %>: null

  data: ->
    <%= underscore_name %>: null

  methods:
    save: ->
      @$emit 'input', @<%= underscore_name %>
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_<%= underscore_name %>:
      immediate: true
      deep: true
      handler: ->
        if @original_<%= underscore_name %>
          @<%= underscore_name %> = @original_<%= underscore_name %>.clone()
        else
          @<%= underscore_name %> = null
</script>
