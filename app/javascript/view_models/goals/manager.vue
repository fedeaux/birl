<template lang="pug">
.entity-manager.goals-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_goal')
    goals-form(v-model='form_goal'
               @save='saveFormGoal()'
               @cancel='clearFormGoal()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-goal-button.ui.primary.top.attached.fluid.small.icon.button(@click='newGoal')
        i.plus.icon
        |  Add Goal

    .flex-item
      goals-list(:goals='goals'
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
