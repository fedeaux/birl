<template lang="pug">
.vocabularies-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_vocabulary')
    vocabularies-form(v-model='form_vocabulary'
                      @save='saveFormVocabulary()'
                      @cancel='clearFormVocabulary()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newVocabulary')
        i.plus.icon
        |  Add Vocabulary

    .flex-column
      vocabularies-list.flex-item(:vocabularies='vocabularies'
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
