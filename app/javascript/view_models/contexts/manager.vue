<template lang="pug">
.entity-manager.contexts-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_context')
    contexts-form(v-model='form_context'
                  @save='saveFormContext()'
                  @cancel='clearFormContext()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-context-button.ui.primary.top.attached.fluid.small.icon.button(@click='newContext')
        i.plus.icon
        |  Add Context

    .flex-item
      contexts-list(:contexts='contexts'
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
