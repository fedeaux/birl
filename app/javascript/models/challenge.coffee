import BaseModel from './base_model'
import User from './user'

class Challenge extends BaseModel
  @collection = 'challenges'
  @member = 'challenge'
  @class_name = 'Challenge'

  @attributes = ->
    {
      id: {}
      name: {}
      description: {}
      user: { type: User }
    }

export default Challenge
