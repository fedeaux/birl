<template lang="pug">
.entity-manager.vocabularies-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_vocabulary')
    vocabularies-form(v-model='form_vocabulary'
                      @save='saveFormVocabulary()'
                      @cancel='clearFormVocabulary()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-vocabulary-button.ui.primary.top.attached.fluid.small.icon.button(@click='newVocabulary')
        i.plus.icon
        |  Add Vocabulary

    .flex-item
      vocabularies-list(:vocabularies='vocabularies'
                        :allow_actions='true'
                        @edit='editVocabulary($event)'
                        @destroy='destroyVocabulary($event)')
</template>

<script lang="coffee">
import VocabulariesManagerMixin from '../../mixins/vocabularies/manager'

export default
  mixins: [VocabulariesManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
