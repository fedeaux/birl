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
    add_new: 'before'

  methods:
    challengeAdded: (index, challenge) ->
      # console.log 'challengeAdded', index, challenge

    getChallenge: (challenge_id) ->
      index = @challengeIndex challenge_id
      return null if index == -1
      @challenges[index]

    editChallenge: (data) ->
      @setFormChallenge data.challenge

    destroyChallenge: (data) ->
      @challenges_resource.destroy data.challenge, @challengeRemoved

    loadChallenges: ->
      @challenges_resource ?= new ChallengesResource

      if @parent_challenges
        @challengesLoaded challenges: @parent_challenges
        return

      @challenges_resource.index @challengesLoaded, @context

    challengesLoaded: (response) ->
      @challenges = response.challenges

    buildChallenge: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Challenge final_params

    newChallenge: (params = {}) ->
      @setFormChallenge @buildChallenge params

    setFormChallenge: (@form_challenge) ->
      @form_challenge

    clearFormChallenge: ->
      @setFormChallenge null

    challengeIndex: (challenge_id) ->
      for index, challenge of @challenges
        return index if challenge.id == challenge_id

      -1

    saveChallenge: (challenge, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @challengeSaved(data)
          custom_callback(data)

        @challenges_resource.save challenge, callback
        return

      @challenges_resource.save challenge, @challengeSaved

    saveFormChallenge: (custom_callback = false) ->
      @saveChallenge @form_challenge, custom_callback

    createChallenge: (attributes, custom_callback = false) ->
      @saveChallenge @buildChallenge(attributes), custom_callback

    addChallenge: (challenge) ->
      index = @challengeIndex challenge.id

      if index == -1
        if @add_new == 'before'
          @challenges.unshift challenge
          index = 0
        else
          @challenges.push challenge
          index = @challenges.length - 1

      else
        Vue.set @challenges, index, challenge

      @challengeAdded index, challenge

    challengeSaved: (data) ->
      @addChallenge data.challenge
      @clearFormChallenge()

    challengeRemoved: (data) ->
      index = @challengeIndex data.challenge.id
      return if index == -1
      @challenges.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadChallenges()
