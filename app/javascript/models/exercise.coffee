import BaseModel from './base_model'
import User from './user'

class Exercise extends BaseModel
  @collection = 'exercises'
  @member = 'exercise'
  @class_name = 'Exercise'

  @attributes = ->
    {
      id: {}
      name: {}
      user: { type: User }
      slug: {}
    }

export default Exercise
