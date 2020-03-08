import GoalsResource from '../../resources/goals_resource'
import Goal from '../../models/goal'

export default
  props:
    context:
      default: -> {}

    parent_goals: null

  data: ->
    goals: null
    form_goal: null
    add_new: 'before'

  methods:
    goalAdded: (index, goal) ->
      # console.log 'goalAdded', index, goal

    getGoal: (goal_id) ->
      index = @goalIndex goal_id
      return null if index == -1
      @goals[index]

    editGoal: (data) ->
      @setFormGoal data.goal

    destroyGoal: (data) ->
      @goals_resource.destroy data.goal, @goalRemoved

    loadGoals: ->
      @goals_resource ?= new GoalsResource

      if @parent_goals
        @goalsLoaded goals: @parent_goals
        return

      @goals_resource.index @goalsLoaded, @context

    goalsLoaded: (response) ->
      @goals = response.goals

    buildGoal: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Goal final_params

    newGoal: (params = {}) ->
      @setFormGoal @buildGoal params

    setFormGoal: (@form_goal) ->
      @form_goal

    clearFormGoal: ->
      @setFormGoal null

    goalIndex: (goal_id) ->
      for index, goal of @goals
        return index if goal.id == goal_id

      -1

    saveGoal: (goal, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @goalSaved(data)
          custom_callback(data)

        @goals_resource.save goal, callback
        return

      @goals_resource.save goal, @goalSaved

    saveFormGoal: (custom_callback = false) ->
      @saveGoal @form_goal, custom_callback

    createGoal: (attributes, custom_callback = false) ->
      @saveGoal @buildGoal(attributes), custom_callback

    addGoal: (goal) ->
      index = @goalIndex goal.id

      if index == -1
        if @add_new == 'before'
          @goals.unshift goal
          index = 0
        else
          @goals.push goal
          index = @goals.length - 1

      else
        Vue.set @goals, index, goal

      @goalAdded index, goal

    goalSaved: (data) ->
      @addGoal data.goal
      @clearFormGoal()

    goalRemoved: (data) ->
      index = @goalIndex data.goal.id
      return if index == -1
      @goals.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadGoals()
