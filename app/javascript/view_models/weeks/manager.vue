<template lang="pug">
.weeks-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_week')
    weeks-form(v-model='form_week'
               @save='saveFormWeek()'
               @cancel='clearFormWeek()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newWeek')
        i.plus.icon
        |  Add Week

    .flex-column
      weeks-list.flex-item(:weeks='weeks'
                           :allow_actions='true'
                           @edit='editWeek($event)'
                           @destroy='destroyWeek($event)')
</template>

<script lang="coffee">
import WeeksManagerMixin from '../../mixins/weeks/manager'

export default
  mixins: [WeeksManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
