import BaseModel from './base_model'

class User extends BaseModel
  @collection = 'users'
  @member = 'user'
  @class_name = 'User'

  @attributes = ->
    {
      id: {}
      email: {}
    }

export default User
