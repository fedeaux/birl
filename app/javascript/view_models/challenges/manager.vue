<template lang="pug">
.entity-manager.challenges-manager.default-container
  .entity-manager-form(v-if='form_challenge')
    challenges-form(v-model='form_challenge'
                    @save='saveFormChallenge()'
                    @cancel='clearFormChallenge()')

  .entity-manager-list(v-else)
    #new-challenge-button.ui.primary.top.attached.fluid.small.icon.button(@click='newChallenge')
      | Add

    challenges-list(:challenges='challenges')
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'
import Challenge from '../../models/challenge'

export default
  props:
    context:
      default: -> {}

  data: ->
    challenges: null
    form_challenge: null

  methods:
    loadChallenges: ->
      @challenges_resource.index @challengesLoaded, @context

    challengesLoaded: (response) ->
      @challenges = response.challenges

    newChallenge: ->
      @setFormChallenge new Challenge(@context)

    setFormChallenge: (@form_challenge) ->

    clearFormChallenge: ->
      @setFormChallenge null

    challengeIndex: (challenge_id) ->
      for index, challenge of @challenges
        return index if challenge.id == challenge_id

      -1

    saveFormChallenge: ->
      @challenges_resource.save @form_challenge, @challengeSaved

    addChallenge: (challenge) ->
      index = @challengeIndex challenge.id

      if index == -1
        @challenges.push challenge
        return

      Vue.set @challenges, index, challenge

    challengeSaved: (data) ->
      @addChallenge data.challenge

  mounted: ->
    @challenges_resource = new ChallengesResource
    @loadChallenges()
</script>
