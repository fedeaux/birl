import Base from './base'
import EntryValueSet from '../models/entry_value_set'

class SingDrillsCycle extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @intervals = @lister.list('musical_small_intervals').sort()

    @new_entry.value.sets[0] = new EntryValueSet(mult: 3, pause: 15, rest: 30)
    @new_entry.value.sets[0].execution = @executionFromArray(@intervals, @new_entry.value.sets[0].mult)

    @new_entry.value.sets[1] = new EntryValueSet(mult: 12, time: 6, pause: 6, rest: 30)
    @new_entry.value.sets[1].execution = @executionFromList('musical_notes_with_height', @new_entry.value.sets[1].mult)

    @new_entry.value.sets[2] = new EntryValueSet(mult: 1, time: 120, rest: 30)
    @new_entry.value.sets[2].execution = @executionFromList('Vocal Regions', @new_entry.value.sets[2].mult)

    @new_entry.value.sets[3] = new EntryValueSet(mult: 3, pause: 15, rest: 30)
    @new_entry.value.sets[3].execution = @executionFromArray(@intervals, @new_entry.value.sets[3].mult)

    @new_entry.value.sets[4] = new EntryValueSet(mult: 4, time: 10, rest: 30)
    @new_entry.value.sets[4].execution = @executionFromArray(['Fry'], @new_entry.value.sets[4].mult)

    @new_entry

export default SingDrillsCycle
