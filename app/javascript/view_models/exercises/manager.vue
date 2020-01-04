<template lang="pug">
.entity-manager.exercises-manager.default-container
  .entity-manager-form(v-if='form_exercise')
    exercises-form(v-model='form_exercise'
                   @save='saveFormExercise()'
                   @cancel='clearFormExercise()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-exercise-button.ui.primary.top.attached.fluid.small.icon.button(@click='newExercise')
        i.plus.icon
        |  Add Exercise

    exercises-list(:exercises='exercises'
                   :allow_actions='true'
                   @edit='editExercise($event)'
                   @destroy='destroyExercise($event)')
</template>

<script lang="coffee">
import ExercisesManagerMixin from '../../mixins/exercises/manager'

export default
  mixins: [ExercisesManagerMixin]
</script>
