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
    add_new: 'before'

  methods:
    groupAdded: (index, group) ->
      # console.log 'groupAdded', index, group

    getGroup: (group_id) ->
      index = @groupIndex group_id
      return null if index == -1
      @groups[index]

    editGroup: (data) ->
      @setFormGroup data.group

    destroyGroup: (data) ->
      @groups_resource.destroy data.group, @groupRemoved

    loadGroups: ->
      @groups_resource ?= new GroupsResource

      if @parent_groups
        @groupsLoaded groups: @parent_groups
        return

      @groups_resource.index @groupsLoaded, @context

    groupsLoaded: (response) ->
      @groups = response.groups

    buildGroup: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Group final_params

    newGroup: (params = {}) ->
      @setFormGroup @buildGroup params

    setFormGroup: (@form_group) ->
      @form_group

    clearFormGroup: ->
      @setFormGroup null

    groupIndex: (group_id) ->
      for index, group of @groups
        return index if group.id == group_id

      -1

    saveGroup: (group, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @groupSaved(data)
          custom_callback(data)

        @groups_resource.save group, callback
        return

      @groups_resource.save group, @groupSaved

    saveFormGroup: (custom_callback = false) ->
      @saveGroup @form_group, custom_callback

    createGroup: (attributes, custom_callback = false) ->
      @saveGroup @buildGroup(attributes), custom_callback

    addGroup: (group) ->
      index = @groupIndex group.id

      if index == -1
        if @add_new == 'before'
          @groups.unshift group
          index = 0
        else
          @groups.push group
          index = @groups.length - 1

      else
        Vue.set @groups, index, group

      @groupAdded index, group

    groupSaved: (data) ->
      @addGroup data.group
      @clearFormGroup()

    groupRemoved: (data) ->
      index = @groupIndex data.group.id
      return if index == -1
      @groups.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadGroups()
