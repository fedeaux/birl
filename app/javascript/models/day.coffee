import BaseModel from './base_model'
import User from './user'

class Day extends BaseModel
  @collection = 'days'
  @member = 'day'
  @class_name = 'Day'

  @attributes = ->
    {
      id: {}
      name: {}
      stamp: {}
      user: { type: User }
      user_id: {}
      planned: {}
      meta: {}
    }

export default Day
