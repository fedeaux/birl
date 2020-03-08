<template lang="pug">
.entity-form-wrapper.goals-form-wrapper.default-container(v-if='goal')
  .entity-form.goals-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='goal.name')

      .field
        label Type
        input(type='text' v-model='goal.type')

      .field
        label Meta

      .field
        label Recurrence Scheme

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import GoalsResource from '../../resources/goals_resource'
import Goal from '../../models/goal'

export default
  model:
    prop: 'original_goal'

  props:
    original_goal: null

  data: ->
    goal: null

  methods:
    save: ->
      @$emit 'input', @goal
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_goal:
      immediate: true
      deep: true
      handler: ->
        if @original_goal
          @goal = @original_goal.clone()
        else
          @goal = null
</script>
