import BaseModel from './base_model'
import Tag from './tag'

class Timelog extends BaseModel
  @collection = 'timelogs'
  @member = 'timelog'
  @class_name = 'Timelog'

  @attributes = ->
    {
      id: {}
      start: { type: moment }
      finish: { type: moment }
      main_tag: { type: Tag }
      description: {}
      meta: {}
    }

  color: ->
    @main_tag.color.hex

  background_color: ->
    @main_tag.background_color.hex

export default Timelog
