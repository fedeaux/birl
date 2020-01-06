<template lang="pug">
.entity-manager.memes-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_meme')
    memes-form(v-model='form_meme'
               @save='saveFormMeme()'
               @cancel='clearFormMeme()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-meme-button.ui.primary.top.attached.fluid.small.icon.button(@click='newMeme')
        i.plus.icon
        |  Add Meme

    memes-list(:memes='memes'
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
