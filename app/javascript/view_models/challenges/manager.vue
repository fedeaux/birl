<template lang="pug">
.entity-manager.challenges-manager.default-container
  //- BrainDamage: ManagerHead Start
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_challenge')
    challenges-form(v-model='form_challenge'
                    @save='saveFormChallenge()'
                    @cancel='clearFormChallenge()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-challenge-button.ui.primary.top.attached.fluid.small.icon.button(@click='newChallenge')
        i.plus.icon
        |  Add Challenge

    .flex-item
      challenges-list(:challenges='challenges'
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
