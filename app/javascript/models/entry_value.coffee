import BaseModel from './base_model'
import EntryValueSet from './entry_value_set'

class EntryValue extends BaseModel
  @collection = 'entry_values'
  @member = 'entry_value'
  @class_name = 'EntryValue'

  @attributes = ->
    {
      global: { type: EntryValueSet }
      sets: { type: EntryValueSet }
      options: {}
    }

export default EntryValue
