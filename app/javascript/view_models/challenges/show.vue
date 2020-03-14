<template lang="pug">
.challenges-show-wrapper.flex-column.t-padded-2(v-if='challenge')
  .challenges-show.flex-item-fixed
    challenges-display(:challenge='challenge')
      shared-link.action-text(:to='challenge.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'

export default
  props:
    parent_challenge: null
    challenge_id:
      default: null

  data: ->
    challenge: null

  methods:
    loadChallenge: ->
      return unless @challenge_id
      @challenges_resource.get @challenge_id, @challengeLoaded

    challengeLoaded: (response) ->
      @challenge = response.challenge

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @challenge = @parent_challenge if @parent_challenge
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    challenge_id:
      immediate: true
      handler: ->
        @challenges_resource ?= new ChallengesResource
        @loadChallenge()
</script>
