import BaseModel from './base_model'
import EntryValueSetExecution from './entry_value_set_execution'

class EntryValueSet extends BaseModel
  @collection = 'entry_value_sets'
  @member = 'entry_value_set'
  @class_name = 'EntryValueSet'

  @attributes = ->
    {
      execution: { type: EntryValueSetExecution }
      mult: {}

      time: {}
      load: {}
      reps: {}
      speed: {}
      bpm: {}
      bpmm: {}

      rest: {}
      pause: {}
    }

  @fromDataModel = (data_model) ->
    set = new EntryValueSet
    for dimension in data_model.dimensions
      set[dimension.name] = @defaults[dimension.name] or 1

    set

  @increase = (dimension_name, current_value) ->
    value = parseFloat current_value

    if dimension_name != 'speed'
      value and value + 1 or 1
    else
      (value and value * 10 + 1 or 10)/10

  @decrease = (dimension_name, current_value) ->
    value = parseFloat current_value
    if dimension_name != 'speed'
      value and value - 1 or 1
    else
      (value and value * 10 - 1 or 10)/10

  @defaults =
    {
      mult: 3

      time: 30
      load: '0'
      reps: 5
      speed: 8
      bpm: 75
      bpmm: 1

      rest: 60
      pause: 20
    }

  human: ->
    str = ''
    if @reps
      str += @reps

      if @load and @load > 0
        str += "x#{@load}kg"

    else if @time
      str += @formattedTime @time

      if @load and @load > 0
        str += "#{@load}kg"

    return "#{@mult}x(#{str})" if @mult and @mult > 1
    str

  human_rest: ->
    return false unless @rest
    @formattedTime @rest

  formattedTime: (seconds) ->
    return "#{seconds}s" if seconds < 60

    minutes = Math.floor(seconds / 6) / 10
    return "#{minutes}m"

  numberOfExecutions: ->
    return @execution.numberOfExecutions(@mult) if @execution
    return parseInt(@mult) if @mult
    1

export default EntryValueSet
