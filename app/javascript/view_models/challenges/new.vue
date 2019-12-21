<template lang="pug">
.entity-new.challenge-new.default-container
  .entity-display
    .entity-display-main New Challenge

  challenges-form(v-model='challenge'
                  @save='saveChallenge'
                  @cancel='back')
</template>

<script lang="coffee">

import ChallengesResource from '../../resources/challenges_resource'
import Challenge from '../../models/challenge'

export default
  data: ->
    challenge: new Challenge

  methods:
    saveChallenge: ->
      @challenges_resource.save @challenge, @saved

    saved: (data) ->
      @$router.push data.challenge.path()

    back: ->
      @$router.push @challenge.collectionPath()

  mounted: ->
    @challenges_resource = new ChallengesResource
</script>
