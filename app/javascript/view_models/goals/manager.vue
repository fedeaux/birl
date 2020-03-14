<template lang="pug">
.goals-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_goal')
    goals-form(v-model='form_goal'
               @save='saveFormGoal()'
               @cancel='clearFormGoal()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newGoal')
        i.plus.icon
        |  Add Goal

    .flex-column
      goals-list.flex-item(:goals='goals'
                           :allow_actions='true'
                           @edit='editGoal($event)'
                           @destroy='destroyGoal($event)')
</template>

<script lang="coffee">
import GoalsManagerMixin from '../../mixins/goals/manager'

export default
  mixins: [GoalsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
