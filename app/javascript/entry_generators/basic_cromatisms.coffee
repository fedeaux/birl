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
    @new_entry.value.sets[0] ||= new EntryValueSet(mult: 1, bpmm: 9/10, rest: 30)
    @new_entry.value.sets[0].execution ||= @executionFromList('cromatisms_warmup', @new_entry.value.sets[0].mult)

    @new_entry.value.sets[1] ||= new EntryValueSet(mult: 2, bpmm: 1, rest: 30)
    @new_entry.value.sets[1].execution ||= @executionFromList('cromatisms_regular', @new_entry.value.sets[1].mult)

    @new_entry.value.sets[2] ||= new EntryValueSet(mult: 1, bpmm: 7/8, rest: 30)
    @new_entry.value.sets[2].execution ||= @executionFromList('cromatisms_hard', @new_entry.value.sets[2].mult)

    @new_entry.value.sets[3] ||= new EntryValueSet(mult: 1, bpmm: 4/3, rest: 30)

    rh = ("Pick: #{cromatism}" for cromatism in @lister.list('cromatisms_regular', @new_entry.value.sets[3].mult))
    @new_entry.value.sets[3].execution ||= @executionFromArray rh

export default BasicCromatisms
