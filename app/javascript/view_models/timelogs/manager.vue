<template lang="pug">
.entity-manager.timelogs-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_timelog')
    timelogs-form(v-model='form_timelog'
                  @save='saveFormTimelog()'
                  @cancel='clearFormTimelog()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-timelog-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTimelog')
        i.plus.icon
        |  Add Timelog

    .flex-item
      timelogs-list(:timelogs='timelogs'
                    :allow_actions='true'
                    @edit='editTimelog($event)'
                    @destroy='destroyTimelog($event)')
</template>

<script lang="coffee">
import TimelogsManagerMixin from '../../mixins/timelogs/manager'

export default
  mixins: [TimelogsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
