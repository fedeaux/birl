<template lang="pug">
.entity-manager.groups-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_group')
    groups-form(v-model='form_group'
                @save='saveFormGroup()'
                @cancel='clearFormGroup()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-group-button.ui.primary.top.attached.fluid.small.icon.button(@click='newGroup')
        i.plus.icon
        |  Add Group

    .flex-item
      groups-list(:groups='groups'
                  :allow_actions='true'
                  @edit='editGroup($event)'
                  @destroy='destroyGroup($event)')
</template>

<script lang="coffee">
import GroupsManagerMixin from '../../mixins/groups/manager'

export default
  mixins: [GroupsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
