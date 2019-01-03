import BaseModel from './base_model'

class Progression extends BaseModel
  @collection = 'progressions'
  @member = 'progression'
  @class_name = 'Progression'

  @attributes = ->
    {
      id: {}
      name: {}
      user_id: {}
      challenge_id: {}
      exercise_id: {}
    }

export default Progression
