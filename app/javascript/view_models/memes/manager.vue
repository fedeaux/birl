<template lang="pug">
.memes-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_meme')
    memes-form(v-model='form_meme'
               @save='saveFormMeme()'
               @cancel='clearFormMeme()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newMeme')
        i.plus.icon
        |  Add Meme

    .flex-column
      memes-list.flex-item(:memes='memes'
                           :allow_actions='true'
                           @edit='editMeme($event)'
                           @destroy='destroyMeme($event)')
</template>

<script lang="coffee">
import MemesManagerMixin from '../../mixins/memes/manager'

export default
  mixins: [MemesManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
