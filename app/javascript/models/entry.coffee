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
      values: {}
      variables: {}
      observations: {}
    }

export default Entry
