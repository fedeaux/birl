<template lang="pug">
.entity-manager.groups-manager.default-container
  .entity-manager-form(v-if='form_group')
    groups-form(v-model='form_group'
                @save='saveFormGroup()'
                @cancel='clearFormGroup()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-group-button.ui.primary.top.attached.fluid.small.icon.button(@click='newGroup')
        i.plus.icon
        |  Add Group

    groups-list(:groups='groups'
                :allow_actions='true'
                @edit='editGroup($event)'
                @destroy='destroyGroup($event)')
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'
import Group from '../../models/group'

export default
  props:
    context:
      default: -> {}

    parent_groups: null

  data: ->
    groups: null
    form_group: null

  methods:
    editGroup: (data) ->
      @setFormGroup data.group

    destroyGroup: (data) ->
      @groups_resource.destroy data.group, @groupRemoved

    loadGroups: ->
      @groups_resource.index @groupsLoaded, @context

    groupsLoaded: (response) ->
      @groups = response.groups

    newGroup: ->
      @setFormGroup new Group @context

    setFormGroup: (@form_group) ->

    clearFormGroup: ->
      @setFormGroup null

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
      @clearFormGroup()

    groupRemoved: (data) ->
      index = @groupIndex data.group.id
      return if index == -1
      @groups.splice index, 1

  mounted: ->
    @groups_resource = new GroupsResource

    if @parent_groups
      @groups = @parent_groups
      return

    @loadGroups()
</script>
