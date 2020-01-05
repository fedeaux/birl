import BaseModel from './base_model'

class Color extends BaseModel
  @collection = 'colors'
  @member = 'color'
  @class_name = 'Color'

  @attributes = ->
    {
      hex: {}
      hsl: {}
      hsv: {}
      rgba: {}
      a: 1
    }

export default Color
