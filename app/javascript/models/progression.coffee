import BaseModel from './base_model'
import User from './user'
import Challenge from './challenge'
import Exercise from './exercise'

class Progression extends BaseModel
  @collection = 'progressions'
  @member = 'progression'
  @class_name = 'Progression'

  @attributes = ->
    {
      id: {}
      name: {}
      user: { type: User }
      challenge: { type: Challenge }
      exercise: { type: Exercise }
      last_entry_at: {}
      details: {}
    }

export default Progression
