<template lang="pug">
.entity-edit.group-edit.default-container
  .entity-display
    .entity-display-main Edit Group

  groups-form(v-model='group'
              v-if='group'
              @save='saveGroup()'
              @cancel='groupDone()')
</template>

<script lang="coffee">

import GroupsResource from '../../resources/groups_resource'
import Group from '../../models/group'

export default
  data: ->
    group: null

  methods:
    loadGroup: ->
      @groups_resource.get @group_id, @groupLoaded

    groupLoaded: (response) ->
      @group = response.group

    saveGroup: ->
      @groups_resource.save @group, @groupDone

    groupDone: ->
      @$router.push @group.path()

  computed:
    group_id: ->
      @$route.params.id

  mounted: ->
    @groups_resource = new GroupsResource
    @loadGroup()
</script>
