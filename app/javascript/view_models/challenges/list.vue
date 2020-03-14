<template lang="pug">
.challenge-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .challenges-list-items-wrapper
      challenges-list-item(v-for='challenge in displayable_challenges'
                           v-if='challenges'
                           :challenge='challenge'
                           :allow_actions='allow_actions'
                           :key='challenge.id'
                           @edit='$emit("edit", { challenge: challenge })'
                           @destroy='$emit("destroy", { challenge: challenge })')

      entity-list-empty(v-if='!challenges || challenges.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    challenges:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (challenge) ->
      (@filter.text == '' or challenge.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_challenges: ->
      return [] unless @challenges

      (challenge for challenge in @challenges when @matchFilters challenge)
</script>
