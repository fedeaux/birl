<template lang="pug">
.entity-manager.goal-entries-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_goal_entry')
    goal-entries-form(v-model='form_goal_entry'
                      @save='saveFormGoalEntry()'
                      @cancel='clearFormGoalEntry()')

  .entity-manager-list.header-contents-footer(v-else)
    .entity-manager-list-header.header-contents-footer-header
      #new-goal-entry-button.ui.primary.top.attached.fluid.small.icon.button(@click='newGoalEntry')
        i.plus.icon
        |  Add Goal Entry

    .header-contents-footer-contents
      goal-entries-list(:goal_entries='goal_entries'
                        :allow_actions='true'
                        @edit='editGoalEntry($event)'
                        @destroy='destroyGoalEntry($event)')
</template>

<script lang="coffee">
import GoalEntriesManagerMixin from '../../mixins/goal_entries/manager'

export default
  mixins: [GoalEntriesManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
