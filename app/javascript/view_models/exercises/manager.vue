<template lang="pug">
.exercises-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_exercise')
    exercises-form(v-model='form_exercise'
                   @save='saveFormExercise()'
                   @cancel='clearFormExercise()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newExercise')
        i.plus.icon
        |  Add Exercise

    .flex-column
      exercises-list.flex-item(:exercises='exercises'
                               :allow_actions='true'
                               @edit='editExercise($event)'
                               @destroy='destroyExercise($event)')
</template>

<script lang="coffee">
import ExercisesManagerMixin from '../../mixins/exercises/manager'

export default
  mixins: [ExercisesManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
