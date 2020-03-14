<template lang="pug">
.progressions-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_progression')
    progressions-form(v-model='form_progression'
                      @save='saveFormProgression()'
                      @cancel='clearFormProgression()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newProgression')
        i.plus.icon
        |  Add Progression

    .flex-column
      progressions-list.flex-item(:progressions='progressions'
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
