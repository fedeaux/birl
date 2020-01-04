<template lang="pug">
.entity-manager.listers-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_lister')
    listers-form(v-model='form_lister'
                 @save='saveFormLister()'
                 @cancel='clearFormLister()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-lister-button.ui.primary.top.attached.fluid.small.icon.button(@click='newLister')
        i.plus.icon
        |  Add Lister

    listers-list(:listers='listers'
                 :allow_actions='true'
                 @edit='editLister($event)'
                 @destroy='destroyLister($event)')
</template>

<script lang="coffee">
import ListersManagerMixin from '../../mixins/listers/manager'

export default
  mixins: [ListersManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
