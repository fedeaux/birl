<template lang="pug">
.days-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_day')
    days-form(v-model='form_day'
              @save='saveFormDay()'
              @cancel='clearFormDay()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newDay')
        i.plus.icon
        |  Add Day

    .flex-column
      days-list.flex-item(:days='days'
                          :allow_actions='true'
                          @edit='editDay($event)'
                          @destroy='destroyDay($event)')
</template>

<script lang="coffee">
import DaysManagerMixin from '../../mixins/days/manager'

export default
  mixins: [DaysManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
