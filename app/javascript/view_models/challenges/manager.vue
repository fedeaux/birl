<template lang="pug">
.entity-manager.challenges-manager.default-container
  .entity-manager-form(v-if='form_challenge')
    challenges-form(v-model='form_challenge'
                    @save='saveFormChallenge()'
                    @cancel='clearFormChallenge()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-challenge-button.ui.primary.top.attached.fluid.small.icon.button(@click='newChallenge')
        i.plus.icon
        |  Add Challenge

    challenges-list(:challenges='challenges'
                    :allow_actions='true'
                    @edit='editChallenge($event)'
                    @destroy='destroyChallenge($event)')
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'
import Challenge from '../../models/challenge'

export default
  props:
    context:
      default: -> {}

    parent_challenges: null

  data: ->
    challenges: null
    form_challenge: null

  methods:
    editChallenge: (data) ->
      @setFormChallenge data.challenge

    destroyChallenge: (data) ->
      @challenges_resource.destroy data.challenge, @challengeRemoved

    loadChallenges: ->
      @challenges_resource.index @challengesLoaded, @context

    challengesLoaded: (response) ->
      @challenges = response.challenges

    newChallenge: ->
      @setFormChallenge new Challenge @context

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
      @clearFormChallenge()

    challengeRemoved: (data) ->
      index = @challengeIndex data.challenge.id
      return if index == -1
      @challenges.splice index, 1

  mounted: ->
    @challenges_resource = new ChallengesResource

    if @parent_challenges
      @challenges = @parent_challenges
      return

    @loadChallenges()
</script>
