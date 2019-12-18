import BaseModel from './base_model'
import Progression from './progression'
import EntryValue from './entry_value'

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
      value: { type: EntryValue }
      observations: {}
      created_at: { type: moment }
    }

  executorDisplay: (options) ->
    return false unless @value

    @value.executorDisplay options

export default Entry
