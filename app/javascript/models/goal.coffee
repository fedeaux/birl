import BaseModel from './base_model'

class Goal extends BaseModel
  @collection = 'goals'
  @member = 'goal'
  @class_name = 'Goal'

  @attributes = ->
    {
      id: {}
      name: {}
      type: {}
      meta: {}
      recurrence_scheme: {}
    }

export default Goal
