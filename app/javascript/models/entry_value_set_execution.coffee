import BaseModel from './base_model'

class EntryValueSetExecution extends BaseModel
  @collection = 'entry_value_set_executions'
  @member = 'entry_value_set_execution'
  @class_name = 'EntryValueSetExecution'

  @attributes = ->
    {
      type: {}
      values: {}
    }

  numberOfExecutions: (set_mult) ->
    return @values.length if @type == 'list'
    set_mult

  executorDisplay: (options) ->
    if !isNaN(options.current_set_execution) && @type == 'list'
      return @values[options.current_set_execution % @values.length]

    false

export default EntryValueSetExecution
