<template lang="pug">
.entity-manager.progressions-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_progression')
    progressions-form(v-model='form_progression'
                      @save='saveFormProgression()'
                      @cancel='clearFormProgression()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-progression-button.ui.primary.top.attached.fluid.small.icon.button(@click='newProgression')
        i.plus.icon
        |  Add Progression

    progressions-list(:progressions='progressions'
                      :allow_actions='true'
                      @edit='editProgression($event)'
                      @destroy='destroyProgression($event)')
</template>

<script lang="coffee">
import ProgressionsManagerMixin from '../../mixins/progressions/manager'

export default
  mixins: [ProgressionsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
