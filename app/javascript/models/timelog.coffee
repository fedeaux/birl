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

  formattedDuration: ->
    parts = []

    minutes = Math.round moment.duration(@finish.diff(@start)).asMinutes()
    hours = parseInt minutes / 60
    minutes -= hours * 60

    if hours > 0
      parts.push "#{hours}h"

    if minutes > 0
      parts.push "#{minutes}m"

    return '--:--' unless parts.length > 0

    parts.join('')

export default Timelog
