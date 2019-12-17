import BaseModel from './base_model'

class EntryValueSet extends BaseModel
  @collection = 'entry_value_sets'
  @member = 'entry_value_set'
  @class_name = 'EntryValueSet'

  @attributes = ->
    {
      execution: {}
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

      if @weight
        str += "x#{@weight}kg"

    str

  human_rest: ->
    return false unless @rest
    @time @rest

  time: (seconds) ->
    return "#{seconds}s" if seconds < 60

    minutes = Math.floor(seconds / 6) / 10
    return "#{minutes}m"

export default EntryValueSet
