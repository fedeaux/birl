<template lang="pug">
.goal-entries-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_goal_entry')
    goal-entries-form(v-model='form_goal_entry'
                      @save='saveFormGoalEntry()'
                      @cancel='clearFormGoalEntry()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newGoalEntry')
        i.plus.icon
        |  Add Goal Entry

    .flex-column
      goal-entries-list.flex-item(:goal_entries='goal_entries'
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
