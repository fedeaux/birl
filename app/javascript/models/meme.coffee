import BaseModel from './base_model'
import User from './user'
import MemeContents from './meme_contents'

class Meme extends BaseModel
  @collection = 'memes'
  @member = 'meme'
  @class_name = 'Meme'

  @attributes = ->
    {
      id: {}
      type: {}
      contents: { type: MemeContents }
    }

export default Meme
