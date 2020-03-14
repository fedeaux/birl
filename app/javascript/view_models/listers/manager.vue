<template lang="pug">
.listers-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_lister')
    listers-form(v-model='form_lister'
                 @save='saveFormLister()'
                 @cancel='clearFormLister()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newLister')
        i.plus.icon
        |  Add Lister

    .flex-column
      listers-list.flex-item(:listers='listers'
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
