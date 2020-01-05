import BaseModel from './base_model'
import Color from './color'

class Tag extends BaseModel
  @collection = 'tags'
  @member = 'tag'
  @class_name = 'Tag'

  @attributes = ->
    {
      id: {}
      name: {}
      color: { type: Color }
      background_color: { type: Color }
      meta: {}
      parent_id: {}
      children: { type: Tag }
    }

  @serializableAttributes = ->
    {
      id: {}
      name: {}
      color: { type: Color }
      background_color: { type: Color }
      meta: {}
      parent_id: {}
    }

export default Tag
