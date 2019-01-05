import BaseModel from './base_model'
import Training from './training'

class Session extends BaseModel
  @collection = 'sessions'
  @member = 'session'
  @class_name = 'Session'

  @attributes = ->
    {
      id: {}
      name: {}
      training: { type: Training }
    }

export default Session
