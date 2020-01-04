<template lang="pug">
  shared-modal(v-if='form_challenge' title='New Challenge')
    challenges-form(v-model='form_challenge'
                   @save='saveFormChallenge()'
                   @cancel='clearFormChallenge()')

  sui-dropdown(:options='challenges_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Challenge'
               v-else
               v-model='selected_challenge_id')

</template>

<script lang="coffee">
import ChallengesManagerMixin from '../../mixins/challenges/manager'

export default
  mixins: [ChallengesManagerMixin]

  model:
    prop: 'challenge_id'

  props:
    challenge_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_challenge_id: null

  methods:
    challengeAdded: (index, challenge) ->
      @selectChallenge challenge

    selectChallenge: (challenge) ->
      @selected_challenge_id = parseInt challenge.id

  computed:
    loading: ->
      !@challenges

    challenges_as_options: ->
      return [] unless @challenges
      { key: challenge.id, value: challenge.id, text: challenge.name } for challenge in @challenges

  watch:
    selected_challenge_id: ->
      selected_challenge_id = parseInt @selected_challenge_id

      unless isNaN selected_challenge_id
        @$emit 'input', selected_challenge_id
        return

      @newChallenge name: @selected_challenge_id

    challenge_id:
      immediate: true
      handler: ->
        return unless @challenge_id
        @selected_challenge_id = parseInt @challenge_id

</script>
