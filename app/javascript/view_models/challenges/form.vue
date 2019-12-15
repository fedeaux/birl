<template lang="pug">
.entity-form-wrapper.challenges-form-wrapper.default-container(v-if='challenge')
  .entity-form.challenges-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='challenge.name')

      .field
        label Description
        input(type='text' v-model='challenge.description')

      .field
        label Context
        contexts-select(v-model='challenge.context_id')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import ChallengesResource from '../../resources/challenges_resource'
import Challenge from '../../models/challenge'

export default
  model:
    prop: 'original_challenge'

  props:
    original_challenge: null

  data: ->
    challenge: null

  methods:
    save: ->
      @$emit 'input', @challenge
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_challenge:
      immediate: true
      deep: true
      handler: ->
        if @original_challenge
          @challenge = @original_challenge.clone()
        else
          @challenge = null
</script>
