<template lang="pug">
.session-progressions-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_session_progression')
    session-progressions-form(v-model='form_session_progression'
                              @save='saveFormSessionProgression()'
                              @cancel='clearFormSessionProgression()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newSessionProgression')
        i.plus.icon
        |  Add Session Progression

    .flex-column
      session-progressions-list.flex-item(:session_progressions='session_progressions'
                                          :allow_actions='true'
                                          @edit='editSessionProgression($event)'
                                          @destroy='destroySessionProgression($event)')
</template>

<script lang="coffee">
import SessionProgressionsManagerMixin from '../../mixins/session_progressions/manager'

export default
  mixins: [SessionProgressionsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
