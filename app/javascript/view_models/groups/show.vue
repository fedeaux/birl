<template lang="pug">
.entity-show-wrapper.groups-show-wrapper.default-container.with-footer
  .entity-show.groups-show(v-if='group')
    h1.entity-show-header
      | {{ group.name }}

  shared-footer(v-if='group')
    router-link.ui.fluid.red.basic.button(:to='group.editPath()')
      | Edit
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'

export default
  data: ->
    group: null
    group_id: null

  methods:
    loadGroup: ->
      @groups_resource.get @group_id, @groupLoaded

    groupLoaded: (response) ->
      @group = response.group

  mounted: ->
    @groups_resource = new GroupsResource
    @group_id = @$route.params.id
    @loadGroup()
</script>
