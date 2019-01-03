import BaseModel from './base_model'

class TrainingSession extends BaseModel
  @collection = 'training_sessions'
  @member = 'training_session'
  @class_name = 'TrainingSession'

  @attributes = ->
    {
      id: {}
      name: {}
      user_id: {}
    }

export default TrainingSession
