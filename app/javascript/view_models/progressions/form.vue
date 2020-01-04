<template lang="pug">
.entity-form-wrapper.progressions-form-wrapper.default-container(v-if='progression')
  .entity-form.progressions-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='progression.name')

      .field
        label Details
        input(type='text' v-model='progression.details')

      .field
        label Challenge
        challenges-select(v-model='progression.challenge_id')

      .field
        label Exercise
        exercises-select(v-model='progression.exercise_id')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'
import Progression from '../../models/progression'

export default
  model:
    prop: 'original_progression'

  props:
    original_progression: null

  data: ->
    progression: null

  methods:
    save: ->
      @$emit 'input', @progression
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_progression:
      immediate: true
      deep: true
      handler: ->
        if @original_progression
          @progression = @original_progression.clone()
        else
          @progression = null
</script>
