<template lang="pug">
.challenges-manager.flex-column
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_challenge')
    challenges-form(v-model='form_challenge'
                    @save='saveFormChallenge()'
                    @cancel='clearFormChallenge()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='newChallenge')
        i.plus.icon
        |  Add Challenge

    .flex-column
      challenges-list.flex-item(:challenges='challenges'
                                :allow_actions='true'
                                @edit='editChallenge($event)'
                                @destroy='destroyChallenge($event)')
</template>

<script lang="coffee">
import ChallengesManagerMixin from '../../mixins/challenges/manager'

export default
  mixins: [ChallengesManagerMixin]

  # BrainDamage: Other Start
  # BrainDamage: Other End

</script>
