<template lang="pug">
.tag-taggables-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_tag_taggable')
    tag-taggables-form(v-model='form_tag_taggable'
                       @save='saveFormTagTaggable()'
                       @cancel='clearFormTagTaggable()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newTagTaggable')
        i.plus.icon
        |  Add Tag Taggable

    .flex-column
      tag-taggables-list.flex-item(:tag_taggables='tag_taggables'
                                   :allow_actions='true'
                                   @edit='editTagTaggable($event)'
                                   @destroy='destroyTagTaggable($event)')
</template>

<script lang="coffee">
import TagTaggablesManagerMixin from '../../mixins/tag_taggables/manager'

export default
  mixins: [TagTaggablesManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
