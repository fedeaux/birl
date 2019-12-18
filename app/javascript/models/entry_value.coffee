import BaseModel from './base_model'
import EntryValueSet from './entry_value_set'

class EntryValue extends BaseModel
  @collection = 'entry_values'
  @member = 'entry_value'
  @class_name = 'EntryValue'

  @attributes = ->
    {
      sets: { type: EntryValueSet }
      options: {}
    }

  executorDisplay: (options) ->
    unless isNaN options.current_set_index
      return @sets[options.current_set_index].executorDisplay(options)

    false

export default EntryValue
