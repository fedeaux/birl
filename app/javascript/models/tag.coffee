import BaseModel from './base_model'
import User from './user'

class Tag extends BaseModel
  @collection = 'tags'
  @member = 'tag'
  @class_name = 'Tag'

  @attributes = ->
    {
      id: {}
      name: {}
      color: {}
      background_color: {}
      meta: {}
      parent_id: {}
      children: { type: Tag }
    }

export default Tag
