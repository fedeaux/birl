<template lang="pug">
.groups-show-wrapper.flex-column.t-padded-2(v-if='group')
  .groups-show.flex-item-fixed
    groups-display(:group='group')
      shared-link.action-text(:to='group.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'

export default
  props:
    parent_group: null
    group_id:
      default: null

  data: ->
    group: null

  methods:
    loadGroup: ->
      return unless @group_id
      @groups_resource.get @group_id, @groupLoaded

    groupLoaded: (response) ->
      @group = response.group

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @group = @parent_group if @parent_group
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    group_id:
      immediate: true
      handler: ->
        @groups_resource ?= new GroupsResource
        @loadGroup()
</script>
