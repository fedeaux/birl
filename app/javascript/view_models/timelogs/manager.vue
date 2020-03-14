<template lang="pug">
.timelogs-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_timelog')
    timelogs-form(v-model='form_timelog'
                  @save='saveFormTimelog()'
                  @cancel='clearFormTimelog()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newTimelog')
        i.plus.icon
        |  Add Timelog

    .flex-column
      timelogs-list.flex-item(:timelogs='timelogs'
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
