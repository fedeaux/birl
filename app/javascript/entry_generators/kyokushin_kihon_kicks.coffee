import Base from './base'
import EntryValueSet from '../models/entry_value_set'

class KyokushinKihonKicks extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @addKicks()
    @new_entry

  addKicks: ->
    secondary_kicks = @lister.list('kyokushin_kicks_secondary', 2)

    # First Set: Basics
    @new_entry.value.sets[0] ||= new EntryValueSet(mult: 3, time: 30, pause: 30, rest: 60)
    @new_entry.value.sets[0].execution =  @executionFromArray ['Mae Geri', 'Right Mawashi Geri', 'Left Mawashi Geri']

    # Second Set: Stretch and Secondary
    @new_entry.value.sets[1] ||= new EntryValueSet(mult: 3, time: 30, pause: 30, rest: 60)
    if @lister.r(2) == 0
      kicks = @lister.list 'kyokushin_kicks_stretch', 2
    else
      kicks = @lister.list 'both_sides', [ 'kyokushin_kicks_stretch_one_leg', 1 ]

    kicks.push secondary_kicks.pop()
    @new_entry.value.sets[1].execution =  @executionFromArray kicks

    # Third Set: Secondary, Hard and Explosive
    @new_entry.value.sets[2] ||= new EntryValueSet(mult: 3, time: 30, pause: 30, rest: 60)
    kicks = [secondary_kicks.pop()]
    kicks.push @lister.item 'kyokushin_kicks_hard'
    kicks.push @lister.item 'kyokushin_kicks_explosive'
    @new_entry.value.sets[2].execution =  @executionFromArray kicks

export default KyokushinKihonKicks
