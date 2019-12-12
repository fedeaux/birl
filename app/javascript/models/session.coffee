import BaseModel from './base_model'
import Training from './training'
import Progression from './progression'

class Session extends BaseModel
  @collection = 'sessions'
  @member = 'session'
  @class_name = 'Session'

  @attributes = ->
    {
      id: {}
      name: {}
      training: { type: Training }
      training_id: {}
      progressions: { type: Progression }
      weekday: {}
      human_weekday: {}
      complete: {}
      updated_at: { type: moment }
    }

export default Session
