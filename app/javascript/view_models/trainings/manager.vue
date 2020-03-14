<template lang="pug">
.entity-manager.trainings-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_training')
    trainings-form(v-model='form_training'
                   @save='saveFormTraining()'
                   @cancel='clearFormTraining()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-training-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTraining')
        i.plus.icon
        |  Add Training

    .flex-item
      trainings-list(:trainings='trainings'
                     :allow_actions='true'
                     @edit='editTraining($event)'
                     @destroy='destroyTraining($event)')
</template>

<script lang="coffee">
import TrainingsManagerMixin from '../../mixins/trainings/manager'

export default
  mixins: [TrainingsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
