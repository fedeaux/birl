import BaseModel from './base_model'
import Goal from './goal'

class GoalEntry extends BaseModel
  @collection = 'goal_entries'
  @member = 'goal_entry'
  @class_name = 'GoalEntry'

  @attributes = ->
    {
      id: {}
      name: {}
      goal: { type: Goal }
      goal_id: {}
      start: {}
      finish: {}
      meta: {}
    }

  widgetComponent: ->
    'item'

export default GoalEntry
