<template lang="pug">
.entity-manager.tag-taggables-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_tag_taggable')
    tag-taggables-form(v-model='form_tag_taggable'
                       @save='saveFormTagTaggable()'
                       @cancel='clearFormTagTaggable()')

  .entity-manager-list.header-contents-footer(v-else)
    .entity-manager-list-header.header-contents-footer-header
      #new-tag-taggable-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTagTaggable')
        i.plus.icon
        |  Add Tag Taggable

    .header-contents-footer-contents
      tag-taggables-list(:tag_taggables='tag_taggables'
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
