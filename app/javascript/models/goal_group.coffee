import BaseModel from './base_model'
import GoalEntry from './goal_entry'

class GoalGroup extends BaseModel
  @collection = 'goal_groups'
  @member = 'goal_group'
  @class_name = 'GoalGroup'

  @attributes = ->
    {
      id: {}
      name: {}
      goal_entries: { type: GoalEntry }
    }

  widgetComponent: ->
    'group'

export default GoalGroup
