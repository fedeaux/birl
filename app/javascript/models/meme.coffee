import BaseModel from './base_model'
import User from './user'
import MemeContents from './meme_contents'
import Tag from './tag'

class Meme extends BaseModel
  @collection = 'memes'
  @member = 'meme'
  @class_name = 'Meme'

  @attributes = ->
    {
      id: {}
      type: {}
      contents: { type: MemeContents }
      tags: { type: Tag }
    }

export default Meme
