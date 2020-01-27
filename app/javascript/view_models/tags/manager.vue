<template lang="pug">
.entity-manager.tags-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_tag')
    tags-form(v-model='form_tag'
              @save='saveFormTag()'
              @cancel='clearFormTag()')

  .entity-manager-list.header-contents-footer(v-else)
    .entity-manager-list-header.header-contents-footer-header
      #new-tag-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTag')
        i.plus.icon
        |  Add Tag

    .header-contents-footer-contents
      tags-list(:tags='tags'
                :allow_actions='true'
                @edit='editTag($event)'
                @destroy='destroyTag($event)')
</template>

<script lang="coffee">
import TagsManagerMixin from '../../mixins/tags/manager'

export default
  mixins: [TagsManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
