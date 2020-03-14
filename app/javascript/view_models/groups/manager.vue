<template lang="pug">
.groups-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_group')
    groups-form(v-model='form_group'
                @save='saveFormGroup()'
                @cancel='clearFormGroup()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newGroup')
        i.plus.icon
        |  Add Group

    .flex-column
      groups-list.flex-item(:groups='groups'
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
