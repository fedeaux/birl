<template lang="pug">
.contexts-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_context')
    contexts-form(v-model='form_context'
                  @save='saveFormContext()'
                  @cancel='clearFormContext()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newContext')
        i.plus.icon
        |  Add Context

    .flex-column
      contexts-list.flex-item(:contexts='contexts'
                              :allow_actions='true'
                              @edit='editContext($event)'
                              @destroy='destroyContext($event)')
</template>

<script lang="coffee">
import ContextsManagerMixin from '../../mixins/contexts/manager'

export default
  mixins: [ContextsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
