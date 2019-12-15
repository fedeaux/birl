import BaseModel from './base_model'
import Context from './context'

class Challenge extends BaseModel
  @collection = 'challenges'
  @member = 'challenge'
  @class_name = 'Challenge'

  @attributes = ->
    {
      id: {}
      name: {}
      description: {}
      context: { type: Context }
      context_id: {}
    }

export default Challenge
