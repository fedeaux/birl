import BaseModel from './base_model'

class Exercise extends BaseModel
  @collection = 'exercises'
  @member = 'exercise'
  @class_name = 'Exercise'

  @attributes = ->
    {
      id: {}
      name: {}
      user_id: {}
    }

export default Exercise
