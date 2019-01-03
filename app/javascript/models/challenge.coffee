import BaseModel from './base_model'

class Challenge extends BaseModel
  @collection = 'challenges'
  @member = 'challenge'
  @class_name = 'Challenge'

  @attributes = ->
    {
      id: {}
      name: {}
      description: {}
      user_id: {}
    }

export default Challenge
