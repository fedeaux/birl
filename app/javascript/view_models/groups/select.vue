<template lang="pug">
  sui-dropdown(:options='groups_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Group'
               v-model='selected_group_id')
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'

export default
  model:
    prop: 'group_id'

  props:
    group_id: null

  data: ->
    groups: null
    selected_group_id: null

  methods:
    loadGroups: ->
      @groups_resource.index @groupsLoaded

    groupsLoaded: (response) ->
      @groups = response.groups

    groupIndex: (group_id) ->
      for index, group of @groups
        return index if group.id == group_id

      -1

    getGroup: (group_id) ->
      index = @groupIndex group_id
      return null if index == -1
      @groups[index]

  computed:
    loading: ->
      !@groups

    groups_as_options: ->
      return [] unless @groups
      { key: group.id, value: group.id, text: group.name } for group in @groups

  watch:
    selected_group_id: ->
      @$emit 'input', @selected_group_id

    group_id:
      immediate: true
      handler: ->
        return unless @group_id
        @selected_group_id = parseInt @group_id

  mounted: ->
    @groups_resource = new GroupsResource
    @loadGroups()

</script>
