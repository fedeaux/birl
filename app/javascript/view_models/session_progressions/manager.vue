<template lang="pug">
.entity-manager.session-progressions-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_session_progression')
    session-progressions-form(v-model='form_session_progression'
                              @save='saveFormSessionProgression()'
                              @cancel='clearFormSessionProgression()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-session-progression-button.ui.primary.top.attached.fluid.small.icon.button(@click='newSessionProgression')
        i.plus.icon
        |  Add Session Progression

    session-progressions-list(:session_progressions='session_progressions'
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
