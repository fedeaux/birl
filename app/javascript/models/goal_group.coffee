import BaseModel from './base_model'
import Goal from './goal'

class GoalGroup extends BaseModel
  @collection = 'goal_groups'
  @member = 'goal_group'
  @class_name = 'GoalGroup'

  @attributes = ->
    {
      id: {}
      name: {}
      goals: { type: Goal }
    }

  widgetComponent: ->
    'group'

export default GoalGroup
