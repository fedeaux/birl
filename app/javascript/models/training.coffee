import BaseModel from './base_model'
import User from './user'

class Training extends BaseModel
  @collection = 'trainings'
  @member = 'training'
  @class_name = 'Training'

  @attributes = ->
    {
      id: {}
      name: {}
      user: { type: User }
    }

export default Training
