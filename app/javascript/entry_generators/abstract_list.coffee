import Base from './base'
import EntryValueSet from '../models/entry_value_set'

class AbstractList extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @setFromList()
    @new_entry

  setFromList: ->
    for index, set of @new_entry.value.sets
      @new_entry.value.sets[index].execution = @executionFromList(@params.list, @new_entry.value.sets[index].mult)

export default AbstractList
