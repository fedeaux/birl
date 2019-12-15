import BaseModel from './base_model'
import Context from './context'

class User extends BaseModel
  @collection = 'users'
  @member = 'user'
  @class_name = 'User'

  @attributes = ->
    {
      id: {}
      name: {}
      email: {}
      current_context: { type: Context }
      current_context_id: {}
    }

export default User
