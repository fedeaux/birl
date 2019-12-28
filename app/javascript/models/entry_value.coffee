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

  @newSet: (sets, data_model) ->
    return new EntryValueSet JSON.parse JSON.stringify sets[sets.length - 1] if sets and sets.length > 0
    EntryValueSet.fromDataModel data_model

  newSet: (data_model) ->
    @constructor.newSet @sets, data_model

export default EntryValue
