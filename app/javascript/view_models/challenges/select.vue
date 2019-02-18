<template lang="pug">
  sui-dropdown(:options='challenges_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Challenge'
               v-model='selected_challenge_id')
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'

export default
  model:
    prop: 'challenge_id'

  props:
    challenge_id: null

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
      @$emit 'input', @selected_challenge_id

    challenge_id:
      immediate: true
      handler: ->
        return unless @challenge_id
        @selected_challenge_id = parseInt @challenge_id

  mounted: ->
    @challenges_resource = new ChallengesResource
    @loadChallenges()

</script>
