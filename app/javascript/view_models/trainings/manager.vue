<template lang="pug">
.trainings-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_training')
    trainings-form(v-model='form_training'
                   @save='saveFormTraining()'
                   @cancel='clearFormTraining()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newTraining')
        i.plus.icon
        |  Add Training

    .flex-column
      trainings-list.flex-item(:trainings='trainings'
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
