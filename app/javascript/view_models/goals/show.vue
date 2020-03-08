<template lang="pug">
.entity-show-wrapper.goals-show-wrapper.default-container(v-if='goal')
  .header-contents-footer
    .entity-show.goals-show.header-contents-footer-header
      goals-display(:goal='goal')
        shared-link.entity-show-header-actions(:to='goal.editPath()')
          i.edit.icon

    //- BrainDamage: Body Start
    //- BrainDamage: Body End
</template>

<script lang="coffee">
import GoalsResource from '../../resources/goals_resource'

export default
  props:
    parent_goal: null
    goal_id:
      default: null

  data: ->
    goal: null

  methods:
    loadGoal: ->
      return unless @goal_id
      @goals_resource.get @goal_id, @goalLoaded

    goalLoaded: (response) ->
      @goal = response.goal

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @goal = @parent_goal if @parent_goal
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    goal_id:
      immediate: true
      handler: ->
        @goals_resource ?= new GoalsResource
        @loadGoal()
</script>
