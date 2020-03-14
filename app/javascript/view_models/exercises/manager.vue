<template lang="pug">
.entity-manager.exercises-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_exercise')
    exercises-form(v-model='form_exercise'
                   @save='saveFormExercise()'
                   @cancel='clearFormExercise()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-exercise-button.ui.primary.top.attached.fluid.small.icon.button(@click='newExercise')
        i.plus.icon
        |  Add Exercise

    .flex-item
      exercises-list(:exercises='exercises'
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
