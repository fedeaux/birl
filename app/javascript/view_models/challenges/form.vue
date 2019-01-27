<template lang="pug">
</template>

<script lang="coffee">

import Challenge from '../../models/challenge'
import ChallengesResource from '../../resources/challenges_resource'

export default
  props: ['challenge_id']

  data: ->
    challenge: null
    loading: false

  methods:
    save: ->
      # @validate =>
      @loading = true
      @challenges_resource.save @challenge, @challengeSaved

    validate: (onValid) ->
      @$validator.validateAll().then (valid) =>
        onValid() if onValid and valid

    challengeSaved: (data) ->
      @setChallenge data
      @loading = false
      @$router.push name: 'challenges-show', params: { id: @challenge.id }

    setChallenge: (data) ->
      @challenge = data.challenge

    loadChallenge: ->
      @loading = true
      id = @challenge_id or @challenge.id
      return unless id

      @challenges_resource.get id, (data) =>
        @setChallenge data
        @loading = false

  mounted: ->
    @challenges_resource = new ChallengesResource

    if @challenge_id
      @loadChallenge()
    else
      @setChallenge challenge: new Challenge()
</script>
