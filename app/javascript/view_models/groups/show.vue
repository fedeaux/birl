<template lang="pug">
.entity-show-wrapper.groups-show-wrapper.default-container(v-if='group')
  .entity-show.groups-show
    groups-display(:group='group')
      router-link.entity-show-header-actions(:to='group.editPath()')
        i.edit.icon
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'

export default
  props:
    parent_group: null

  data: ->
    group: null
    group_id: null

  methods:
    loadGroup: ->
      @groups_resource.get @group_id, @groupLoaded

    groupLoaded: (response) ->
      @group = response.group

  mounted: ->
    if @parent_group
      @group = @parent_group
      return

    @groups_resource = new GroupsResource
    @group_id = @$route.params.id
    @loadGroup()
</script>
