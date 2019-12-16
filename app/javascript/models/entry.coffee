import BaseModel from './base_model'
import Progression from './progression'

class Entry extends BaseModel
  @collection = 'entries'
  @member = 'entry'
  @class_name = 'Entry'

  @attributes = ->
    {
      id: {}
      name: {}
      progression: { type: Progression }
      progression_id: {}
      values: {}
      value: {}
      observations: {}
      created_at: { type: moment }
    }

export default Entry
