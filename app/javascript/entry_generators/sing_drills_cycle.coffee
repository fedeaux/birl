import Base from './base'
import EntryValueSet from '../models/entry_value_set'

class SingDrillsCycle extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @firstSet()
    @secondSet()
    @thirdSet()

    @new_entry

  firstSet: ->
    @new_entry.value.sets[0] ||= new EntryValueSet(mult: 3, time: 40, pause: 15, rest: 30)
    @new_entry.value.sets[0].execution = @executionFromList('Musical Intervals', @new_entry.value.sets[0].mult)

  secondSet: ->
    @new_entry.value.sets[1] ||= new EntryValueSet(mult: 12, time: 5, pause: 3, rest: 30)
    @new_entry.value.sets[1].execution = @executionFromList('musical_notes_with_height', @new_entry.value.sets[1].mult)

  thirdSet: ->
    @new_entry.value.sets[2] ||= new EntryValueSet(mult: 1, time: 60, rest: 30)
    @new_entry.value.sets[2].execution = @executionFromList('Vocal Regions', @new_entry.value.sets[2].mult)

export default SingDrillsCycle
