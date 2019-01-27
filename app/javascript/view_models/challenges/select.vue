<template lang="pug">
  sui-dropdown(:options='challenges_as_options' :loading='loading' placeholder='Challenge' v-model='selected_challenge_id')
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'

export default
  props:
    value: null

  data: ->
    challenges: null
    selected_challenge_id: null

  methods:
    loadChallenges: ->
      @challenges_resource.index @challengesLoaded

    challengesLoaded: (response) ->
      @challenges = response.challenges

    challengeIndex: (challenge_id) ->
      for index, challenge of @challenges
        return index if challenge.id == challenge_id

      -1

    getChallenge: (challenge_id) ->
      index = @challengeIndex challenge_id
      return null if index == -1
      @challenges[index]

  computed:
    loading: ->
      !@challenges

    challenges_as_options: ->
      return [] unless @challenges
      { key: challenge.id, value: challenge.id, text: challenge.name } for challenge in @challenges

  watch:
    selected_challenge_id: ->
      @$emit 'input', @getChallenge @selected_challenge_id

    value:
      immediate: true
      handler: ->
        return unless @value and @value.id
        @selected_challenge_id = @value.id

  mounted: ->
    @challenges_resource = new ChallengesResource
    @loadChallenges()

</script>
