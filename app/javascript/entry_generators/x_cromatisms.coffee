import Base from './base'
import EntryValueSet from '../models/entry_value_set'

export default class XCromatisms extends Base
  generate: (@new_entry, @entries, @data_model) ->
    @ensureGlobal()
    @addCromatisms()
    @new_entry

  ensureGlobal: ->
    @new_entry.value.global ||= new EntryValueSet bpm: 75

  addCromatisms: ->
    regular_cromatisms = @lister.list 'cromatisms_regular', 3
    warmup_cromatisms = @lister.list 'cromatisms_warmup', 2

    @new_entry.value.sets[0] = new EntryValueSet(mult: 1, bpmm: 1, rest: 30)
    @new_entry.value.sets[0].execution = @executionFromArray [@addVariations warmup_cromatisms[0]]

    @new_entry.value.sets[1] = new EntryValueSet(mult: 1, bpmm: 1, rest: 30)
    @new_entry.value.sets[1].execution = @executionFromArray [@addVariations regular_cromatisms[0]]

    expressions = @lister.list('guitar_expressions', 3)
    i = 2

    options = @shuffle [
      { mult: 1, bpmm: 5/4, rest: 30, execution: @executionFromArray(["Pick"]) }

      { mult: 1, bpmm: 0.75, rest: 30, execution: @executionFromArray(['6/4: 1234']) }

      { mult: 1, bpmm: 1, rest: 30, execution: @executionFromList('arpeggios', 1) }

      { mult: 1, bpmm: 0, rest: 30, execution: @executionFromArray([expressions.join(' / ')]) }
    ]

    while i < 4
      option = options.pop()
      @new_entry.value.sets[i] = new EntryValueSet option
      @new_entry.value.sets[i].execution = option.execution
      i += 1

    @new_entry.value.sets[i] = new EntryValueSet(mult: 3, bpmm: 9/10, rest: 30)
    @new_entry.value.sets[i].execution = @executionFromArray ["Free tation"]

  addVariations: (chromatism) ->
    [
      { text: chromatism }
      { text: @lister.item 'easy_cromatisms_variations' }
      { ascii_drawing: { model: 'fretboard', preset: 'x', chromatism: chromatism } }
    ]

  shuffle: (source) ->
    # Arrays with < 2 elements do not shuffle well. Instead make it a noop.
    return source unless source.length >= 2
    # From the end of the list to the beginning, pick element `index`.
    for index in [source.length-1..1]
      # Choose random element `randomIndex` to the front of `index` to swap with.
      randomIndex = Math.floor Math.random() * (index + 1)
      # Swap `randomIndex` with `index`, using destructured assignment
      [source[index], source[randomIndex]] = [source[randomIndex], source[index]]
    source
