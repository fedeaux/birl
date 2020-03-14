<template lang="pug">
.sessions-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_session')
    sessions-form(v-model='form_session'
                  @save='saveFormSession()'
                  @cancel='clearFormSession()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newSession')
        i.plus.icon
        |  Add Session

    .flex-column
      sessions-list.flex-item(:sessions='sessions'
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
