import BaseModel from './base_model'
class EntryValueSetExecution extends BaseModel

class EntryValueSetExecution extends BaseModel
  @collection = 'entry_value_set_executions'
  @member = 'entry_value_set_execution'
  @class_name = 'EntryValueSetExecution'

  @attributes = ->
    {
      type: {}
      values: {}
      variations: {}
    }

  numberOfExecutions: (set_mult) ->
    return @values.length if @type == 'list'
    set_mult

  getValue: (set_execution) ->
    index = (set_execution - 1) % @values.length
    value = @values[index]

    return value if _.isArray value

    [{ text: value }]

export default EntryValueSetExecution
