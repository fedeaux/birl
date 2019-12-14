<template lang="pug">
.entity-form-wrapper.<%= plural_underscore_name %>-form-wrapper.default-container(v-if='<%= underscore_name %>')
  .entity-form.<%= plural_underscore_name %>-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='<%= underscore_name %>.name')

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

  mounted: ->

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
