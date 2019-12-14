import BaseModel from './base_model'
import User from './user'
import Group from './group'

class Exercise extends BaseModel
  @collection = 'exercises'
  @member = 'exercise'
  @class_name = 'Exercise'

  @attributes = ->
    {
      id: {}
      name: {}
      slug: {}
      progression_type: {}
      user: { type: User }
      user_id: {}
      group: { type: Group }
      group_id: {}
    }

export default Exercise
