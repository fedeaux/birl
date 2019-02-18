<template lang="pug">
  sui-dropdown(:options='groups_as_options' :loading='loading' placeholder='Group' v-model='selected_group_id')
</template>

<script lang="coffee">
import GroupsResource from '../../resources/groups_resource'

export default
  props:
    value: null

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
      @$emit 'input', @getGroup @selected_group_id

    value:
      immediate: true
      handler: ->
        return unless @value and @value.id
        @selected_group_id = @value.id

  mounted: ->
    @groups_resource = new GroupsResource
    @loadGroups()

</script>
