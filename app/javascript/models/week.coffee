import BaseModel from './base_model'
import User from './user'

class Week extends BaseModel
  @collection = 'weeks'
  @member = 'week'
  @class_name = 'Week'

  @attributes = ->
    {
      id: {}
      name: {}
      stamp: {}
      user: { type: User }
      user_id: {}
      meta: {}
    }

export default Week
