import BaseModel from './base_model'
import Meme from './meme'
import Tag from './tag'

class TagTaggable extends BaseModel
  @collection = 'tag_taggables'
  @member = 'tag_taggable'
  @class_name = 'TagTaggable'

  @attributes = ->
    {
      id: {}
      taggable: { type: Meme }
      taggable_id: {}
      tag: { type: Tag }
      tag_id: {}
    }

export default TagTaggable
