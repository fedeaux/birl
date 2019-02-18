import BaseModel from './base_model'
import User from './user'
import Exercise from './exercise'

class Group extends BaseModel
  @collection = 'groups'
  @member = 'group'
  @class_name = 'Group'

  @attributes = ->
    {
      id: {}
      name: {}
      user: { type: User }
      exercises: { type: Exercise }
      user_id: {}
    }

export default Group
