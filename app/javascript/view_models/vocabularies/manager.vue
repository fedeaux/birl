<template lang="pug">
.entity-manager.vocabularies-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_vocabulary')
    vocabularies-form(v-model='form_vocabulary'
                      @save='saveFormVocabulary()'
                      @cancel='clearFormVocabulary()')

  .entity-manager-list.header-contents-footer(v-else)
    .entity-manager-list-header.header-contents-footer-header
      #new-vocabulary-button.ui.primary.top.attached.fluid.small.icon.button(@click='newVocabulary')
        i.plus.icon
        |  Add Vocabulary

    .header-contents-footer-contents
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
