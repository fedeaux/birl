import BaseModel from './base_model'
import Meme from './meme'
import Tag from './tag'
import GoalEntry from './goal_entry'

export default class GoalsPeriod extends BaseModel
  @collection = 'goals_periods'
  @member = 'goals_period'
  @class_name = 'GoalsPeriod'

  @attributes = ->
    {
      name: {}
      items: { type: GoalEntry }
    }
