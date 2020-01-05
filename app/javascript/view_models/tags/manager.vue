<template lang="pug">
.entity-manager.tags-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_tag')
    tags-form(v-model='form_tag'
              @save='saveFormTag()'
              @cancel='clearFormTag()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-tag-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTag')
        i.plus.icon
        |  Add Tag

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
