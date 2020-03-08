<template lang="pug">
  shared-modal(v-if='form_goal' title='New Goal')
    goals-form(v-model='form_goal'
                   @save='saveFormGoal()'
                   @cancel='clearFormGoal()')

  sui-dropdown(:options='goals_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Goal'
               v-else
               v-model='selected_goal_id')

</template>

<script lang="coffee">
import GoalsManagerMixin from '../../mixins/goals/manager'

export default
  mixins: [GoalsManagerMixin]

  model:
    prop: 'goal_id'

  props:
    goal_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_goal_id: null

  methods:
    goalAdded: (index, goal) ->
      @selectGoal goal

    selectGoal: (goal) ->
      @selected_goal_id = parseInt goal.id

  computed:
    loading: ->
      !@goals

    goals_as_options: ->
      return [] unless @goals
      { key: goal.id, value: goal.id, text: goal.name } for goal in @goals

  watch:
    selected_goal_id: ->
      selected_goal_id = parseInt @selected_goal_id

      unless isNaN selected_goal_id
        @$emit 'input', selected_goal_id
        return

      @newGoal name: @selected_goal_id

    goal_id:
      immediate: true
      handler: ->
        return unless @goal_id
        @selected_goal_id = parseInt @goal_id

</script>
