import Base from './base'
import EntryValueSet from '../models/entry_value_set'

export default class KyokushinKihonKicks extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @addKicks()
    @slice()
    @new_entry

  addKicks: ->
    secondary_kicks = @lister.list('kyokushin_kicks_secondary', 2)

    # First Set: Basics
    [1..2].forEach (i) =>
      @addSet(
        { time: 30 }
        { mult: 1, pause: 15, rest: 15 }
        @executionFromValue 'Mae Geri'
      )

      @addSet(
        {} # UNDO THIS!!!!!!!!!!!!!!
        { mult: 2, pause: 15, rest: i * 30, time: 15 }
        @executionFromArray ['Left Mawashi Geri', 'Right Mawashi Geri']
      )

    # Second Set: Stretch and Secondary
    if @lister.r(2) == 0
      @addSet(
        {}
        { mult: 2, pause: 15, rest: 30, time: 30 }
        @executionFromList 'kyokushin_kicks_stretch', 2
      )
    else
      @addSet(
        {}
        { mult: 4, pause: 15, rest: 30, time: 15 }
        @executionFromArray ['Left Mae Keage Geri', 'Right Mae Keage Geri']
      )

    @addSet(
      {}
      { mult: 1, rest: 60, time: 45 }
      @executionFromValue secondary_kicks.pop()
    )

    # Third Set: Hard and Secondary (Explosive not yet)
    @addSet(
      {}
      { mult: 2, rest: 30, time: 60, pause: 15 }
      @executionFromList 'kyokushin_kicks_hard', 2
    )

    @addSet(
      {}
      { mult: 1, rest: 30, time: 45 }
      @executionFromValue secondary_kicks.pop()
    )
