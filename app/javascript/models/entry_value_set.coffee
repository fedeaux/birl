import BaseModel from './base_model'

class EntryValueSet extends BaseModel
  @collection = 'entry_value_sets'
  @member = 'entry_value_set'
  @class_name = 'EntryValueSet'

  @attributes = ->
    {
      execution: {}
      sets: {}
      time: {}
      seconds: {}
      weight: {}
      reps: {}
      rest: {}
      speed: {}
      bpmm: {}
    }

  human: ->
    str = ''
    if @reps
      str += @reps

      if @weight and @weight > 0
        str += "x#{@weight}kg"

    else if @time
      str += @formattedTime @time

      if @weight and @weight > 0
        str += "w#{@weight}kg"

    return "[#{@sets} sets] #{str}" if @sets and @sets > 0
    str

  human_rest: ->
    return false unless @rest
    @formattedTime @rest

  formattedTime: (seconds) ->
    return "#{seconds}s" if seconds < 60

    minutes = Math.floor(seconds / 6) / 10
    return "#{minutes}m"

export default EntryValueSet
