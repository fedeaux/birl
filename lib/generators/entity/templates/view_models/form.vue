<template lang="pug">
.entity-form-wrapper.<%= plural_underscore_name %>-form-wrapper.default-container(v-if='<%= underscore_name %>')
  .entity-form.<%= plural_underscore_name %>-form
    form.ui.form
      .field
        label Name
        input(type='text')

      .field
        label Exercise
        exercises-select(v-model='<%= underscore_name %>.exercise')

      .field
        label Challenge
        challenges-select(v-model='<%= underscore_name %>.challenge')

      .field
        .ui.primary.button(@click='save()') Save

</template>

<script lang="coffee">
import <%= plural_entity_name %>Resource from '../../resources/<%= plural_underscore_name %>_resource'
import <%= entity_name %> from '../../models/<%= underscore_name %>'

export default
  props:
    original_<%= underscore_name %>: null

  data: ->
    <%= underscore_name %>: null

  methods:
    save: ->

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
