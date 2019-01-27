<template lang="pug">
.entity-form-wrapper.progressions-form-wrapper.default-container(v-if='progression')
  .entity-form.progressions-form
    form.ui.form
      .field
        label Name
        input(type='text')

      .field
        label Exercise
        exercises-select(v-model='progression.exercise')

      .field
        label Challenge
        challenges-select(v-model='progression.challenge')

      .field
        .ui.primary.button(@click='save()') Save

</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'
import Progression from '../../models/progression'

export default
  props:
    original_progression: null

  data: ->
    progression: null

  methods:
    save: ->

  mounted: ->

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
