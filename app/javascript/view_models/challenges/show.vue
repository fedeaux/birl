<template lang="pug">
.entity-show-wrapper.challenges-show-wrapper.default-container
  .entity-show.challenges-show(v-if='challenge')
    h1.entity-show-header
      | {{ challenge.name }}

    .centered
      | {{ challenge.description }}
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'

export default
  data: ->
    challenge: null
    challenge_id: null

  methods:
    loadChallenge: ->
      @challenges_resource.get @challenge_id, @challengeLoaded

    challengeLoaded: (response) ->
      @challenge = response.challenge

  mounted: ->
    @challenges_resource = new ChallengesResource
    @challenge_id = @$route.params.id
    @loadChallenge()
</script>

# NO-OVERRIDE
