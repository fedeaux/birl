<template lang="pug">
.entity-manager.sessions-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_session')
    sessions-form(v-model='form_session'
                  @save='saveFormSession()'
                  @cancel='clearFormSession()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-session-button.ui.primary.top.attached.fluid.small.icon.button(@click='newSession')
        i.plus.icon
        |  Add Session

    sessions-list(:sessions='sessions'
                  :allow_actions='true'
                  @edit='editSession($event)'
                  @destroy='destroySession($event)')
</template>

<script lang="coffee">
import SessionsManagerMixin from '../../mixins/sessions/manager'

export default
  mixins: [SessionsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
