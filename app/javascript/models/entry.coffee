import BaseModel from './base_model'
import Progression from './progression'
import EntryValue from './entry_value'
import EntryValueSet from './entry_value_set'

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
      data_model: {}
    }

  @fromDataModelAndContext = (context, data_model) ->
    new_set = EntryValueSet.fromDataModel data_model
    new Entry _.extend {}, context, { value: { sets: [new_set] } }

export default Entry
