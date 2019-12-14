<template lang="pug">
.entity-edit.challenge-edit.default-container
  challenges-form(v-model='challenge'
                  v-if='challenge'
                  @save='saveChallenge()'
                  @cancel='challengeDone()')
</template>

<script lang="coffee">

import ChallengesResource from '../../resources/challenges_resource'
import Challenge from '../../models/challenge'

export default
  data: ->
    challenge: null

  methods:
    loadChallenge: ->
      @challenges_resource.get @challenge_id, @challengeLoaded

    challengeLoaded: (response) ->
      @challenge = response.challenge

    saveChallenge: ->
      @challenges_resource.save @challenge, @challengeDone

    challengeDone: ->
      @$router.push @challenge.path()

  computed:
    challenge_id: ->
      @$route.params.id

  mounted: ->
    @challenges_resource = new ChallengesResource
    @loadChallenge()
</script>
