import BaseModel from './base_model'
import User from './user'

class Context extends BaseModel
  @collection = 'contexts'
  @member = 'context'
  @class_name = 'Context'

  @attributes = ->
    {
      id: {}
      name: {}
      slug: {}
      color: {}
      user: { type: User }
      user_id: {}
      meta: {}
    }

export default Context
