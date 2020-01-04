<template lang="pug">
  shared-modal(v-if='form_group' title='New Group')
    groups-form(v-model='form_group'
                   @save='saveFormGroup()'
                   @cancel='clearFormGroup()')

  sui-dropdown(:options='groups_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Group'
               v-else
               v-model='selected_group_id')

</template>

<script lang="coffee">
import GroupsManagerMixin from '../../mixins/groups/manager'

export default
  mixins: [GroupsManagerMixin]

  model:
    prop: 'group_id'

  props:
    group_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_group_id: null

  methods:
    groupAdded: (index, group) ->
      @selectGroup group

    selectGroup: (group) ->
      @selected_group_id = parseInt group.id

  computed:
    loading: ->
      !@groups

    groups_as_options: ->
      return [] unless @groups
      { key: group.id, value: group.id, text: group.name } for group in @groups

  watch:
    selected_group_id: ->
      selected_group_id = parseInt @selected_group_id

      unless isNaN selected_group_id
        @$emit 'input', selected_group_id
        return

      @newGroup name: @selected_group_id

    group_id:
      immediate: true
      handler: ->
        return unless @group_id
        @selected_group_id = parseInt @group_id

</script>
