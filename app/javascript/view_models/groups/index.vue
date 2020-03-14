<template lang="pug">
groups-manager.groups-index(:parent_groups='groups')
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'

export default
  data: ->
    groups: null

  methods:
    loadGroups: ->
      @groups_resource.index @groupsLoaded

    groupsLoaded: (response) ->
      @groups = response.groups

  mounted: ->
    @groups_resource = new GroupsResource
    @loadGroups()
</script>
