import BaseModel from './base_model'
import Context from './context'
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
      context: { type: Context }
      context_id: {}
      group: { type: Group }
      group_id: {}
    }

export default Exercise
