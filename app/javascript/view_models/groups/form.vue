<template lang="pug">
.entity-form-wrapper.groups-form-wrapper.default-container(v-if='group')
  .entity-form.groups-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='group.name')

      .field
        label Context
        contexts-select(v-model='group.context_id')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'
import Group from '../../models/group'

export default
  model:
    prop: 'original_group'

  props:
    original_group: null

  data: ->
    group: null

  methods:
    save: ->
      @$emit 'input', @group
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_group:
      immediate: true
      deep: true
      handler: ->
        if @original_group
          @group = @original_group.clone()
        else
          @group = null
</script>
