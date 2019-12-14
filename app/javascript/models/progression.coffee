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
      details: {}
      user: { type: User }
      user_id: {}
      challenge: { type: Challenge }
      challenge_id: {}
      exercise: { type: Exercise }
      exercise_id: {}
      last_entry_at: { type: moment }
      entries_count: {}
      exercise_name: {}
      challenge_name: {}
      done_today: {}
      progression_type: {}
    }

export default Progression
