<template lang="pug">
challenges-manager.challenges-index(:parent_challenges='challenges')
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'

export default
  data: ->
    challenges: null

  methods:
    loadChallenges: ->
      @challenges_resource.index @challengesLoaded

    challengesLoaded: (response) ->
      @challenges = response.challenges

  mounted: ->
    @challenges_resource = new ChallengesResource
    @loadChallenges()
</script>
