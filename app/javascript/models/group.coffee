import BaseModel from './base_model'
import Context from './context'

class Group extends BaseModel
  @collection = 'groups'
  @member = 'group'
  @class_name = 'Group'

  @attributes = ->
    {
      id: {}
      name: {}
      context: { type: Context }
      context_id: {}
    }

export default Group
