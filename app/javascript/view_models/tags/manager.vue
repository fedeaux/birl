<template lang="pug">
.tags-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_tag')
    tags-form(v-model='form_tag'
              @save='saveFormTag()'
              @cancel='clearFormTag()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newTag')
        i.plus.icon
        |  Add Tag

    .flex-column
      tags-list.flex-item(:tags='tags'
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
