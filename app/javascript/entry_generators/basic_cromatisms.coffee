import Base from './base'
import EntryValueSet from '../models/entry_value_set'

class BasicCromatisms extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @ensureGlobal()
    @addCromatisms()
    @new_entry

  ensureGlobal: ->
    @new_entry.value.global ||= new EntryValueSet bpm: 75

  addCromatisms: ->
    regular_cromatisms = @lister.list 'cromatisms_regular', 4
    warmup_cromatisms = @lister.list 'cromatisms_warmup', 2

    @new_entry.value.sets[0] = new EntryValueSet(mult: 1, bpmm: 1, rest: 30)
    @new_entry.value.sets[0].execution = @executionFromArray [warmup_cromatisms[0]]

    @new_entry.value.sets[1] = new EntryValueSet(mult: 3, bpmm: 1, rest: 30)
    @new_entry.value.sets[1].execution = @executionFromArray regular_cromatisms.slice(0, 3)

    @new_entry.value.sets[2] = new EntryValueSet(mult: 1, bpmm: 7/8, rest: 30)
    @new_entry.value.sets[2].execution = @executionFromList('cromatisms_hard', @new_entry.value.sets[2].mult)

    @new_entry.value.sets[3] = new EntryValueSet(mult: 1, bpmm: 5/4, rest: 30)
    @new_entry.value.sets[3].execution = @executionFromArray ["Pick: #{regular_cromatisms[3]}"]

    @new_entry.value.sets[4] = new EntryValueSet(mult: 1, bpmm: 7/8, rest: 30)
    @new_entry.value.sets[4].execution = @executionFromArray ["6/4: #{warmup_cromatisms[1]}"]

    @new_entry.value.sets[5] = new EntryValueSet(mult: 1, bpmm: 1, rest: 30)
    @new_entry.value.sets[5].execution = @executionFromList('arpeggios', @new_entry.value.sets[5].mult)

    expressions = @lister.list('guitar_expressions', 3)
    @new_entry.value.sets[6] = new EntryValueSet(mult: 1, bpmm: 0, rest: 30)
    @new_entry.value.sets[6].execution = @executionFromArray [expressions.join(' / ')]

    @new_entry.value.sets[7] = new EntryValueSet(mult: 1, bpmm: 1, rest: 30)
    @new_entry.value.sets[7].execution = @executionFromArray ["Free tation"]

export default BasicCromatisms
