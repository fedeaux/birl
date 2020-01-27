<template lang="pug">
.entity-manager.groups-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_group')
    groups-form(v-model='form_group'
                @save='saveFormGroup()'
                @cancel='clearFormGroup()')

  .entity-manager-list.header-contents-footer(v-else)
    .entity-manager-list-header.header-contents-footer-header
      #new-group-button.ui.primary.top.attached.fluid.small.icon.button(@click='newGroup')
        i.plus.icon
        |  Add Group

    .header-contents-footer-contents
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
