import Base from './base'
import EntryValueSet from '../models/entry_value_set'

export default class WeightedKyokushinKihonKicks extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @addKicks()
    @slice()
    @new_entry

  addKicks: ->
    [1..2].forEach (i) =>
      @addSet(
        {}
        { mult: 1, time: 15, rest: 30 }
        @executionFromValue 'Mae Geri'
      )

      @addSet(
        {}
        { mult: 1, time: 30, rest: 30 }
        @executionFromValue 'Ushiro Geri'
      )

      @addSet(
        {}
        { mult: 1,  time: 20, rest: 60 }
        @executionFromValue 'Yoko Geri'
      )
