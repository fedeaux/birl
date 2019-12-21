<template lang="pug">
.entity-new.group-new.default-container
  .entity-display
    .entity-display-main New Group

  groups-form(v-model='group'
              @save='saveGroup'
              @cancel='back')
</template>

<script lang="coffee">

import GroupsResource from '../../resources/groups_resource'
import Group from '../../models/group'

export default
  data: ->
    group: new Group

  methods:
    saveGroup: ->
      @groups_resource.save @group, @saved

    saved: (data) ->
      @$router.push data.group.path()

    back: ->
      @$router.push @group.collectionPath()

  mounted: ->
    @groups_resource = new GroupsResource
</script>
