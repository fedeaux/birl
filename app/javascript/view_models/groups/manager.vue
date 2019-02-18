<template lang="pug">
.entity-manager.groups-manager.default-container
  .entity-manager-form(v-if='form_group')
    groups-form(v-model='form_group' @save='saveFormGroup()')

  .entity-manager-list(v-else)
    #new-group-button.ui.primary.small.icon.button(@click='newGroup')
      i.add.icon
      | add
    groups-list(:groups='groups')
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'
import Group from '../../models/group'

export default
  props:
    context:
      default: -> {}

  data: ->
    groups: null
    form_group: null

  methods:
    loadGroups: ->
      @groups_resource.index @groupsLoaded, @context

    groupsLoaded: (response) ->
      @groups = response.groups
      @$nextTick ->
        $('#new-group-button').click()

    newGroup: ->
      @setFormGroup new Group(@context)

    setFormGroup: (@form_group) ->

    groupIndex: (group_id) ->
      for index, group of @groups
        return index if group.id == group_id

      -1

    saveFormGroup: ->
      @groups_resource.save @form_group, @groupSaved

    addGroup: (group) ->
      index = @groupIndex group.id

      if index == -1
        @groups.push group
        return

      Vue.set @groups, index, group

    groupSaved: (data) ->
      @addGroup data.group

  mounted: ->
    @groups_resource = new GroupsResource
    @loadGroups()
</script>
