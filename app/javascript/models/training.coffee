import BaseModel from './base_model'
import Context from './context'

class Training extends BaseModel
  @collection = 'trainings'
  @member = 'training'
  @class_name = 'Training'

  @attributes = ->
    {
      id: {}
      name: {}
      context: { type: Context }
      context_id: {}
    }

export default Training
