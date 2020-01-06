import BaseModel from './base_model'

class Meme extends BaseModel
  @collection = 'meme_contents'
  @member = 'meme_contents'
  @class_name = 'MemeContents'

  @attributes = ->
    {
      title: {}
      description: {}
    }

export default Meme
