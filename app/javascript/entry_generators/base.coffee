import EntryValueSet from '../models/entry_value_set'
import EntryValueSetExecution from '../models/entry_value_set_execution'
import Lister from './lister'

class Base
  constructor: (@params = {}) ->
    @lister = new Lister
    @i = 0

  executionFromList: (list, count, variations_list = null) ->
    @executionFromArray @adaptValues @lister.list(list, count), (variations_list && @lister.list(variations_list, count))

  executionFromArray: (values, variations = null) ->
    new EntryValueSetExecution type: 'list', values: values, variations: variations

  executionFromValue: (value) ->
    new EntryValueSetExecution type: 'list', values: [value]

  adaptValues: (values) ->
    return ([{ text: value }] for value in values) if typeof(values[0]) == 'string'
    return ([value] for value in values) if typeof(values[0]) == 'object'

    values

  addSet: (default_attributes = {}, override_attributes = {}, execution = []) ->
    previous_attributes = @new_entry.value.sets[@i]?.serialize() || {}

    merge = @merge default_attributes, previous_attributes, override_attributes

    @new_entry.value.sets[@i] = new EntryValueSet(merge)
    @new_entry.value.sets[@i].execution = execution

    @i += 1

  slice: (at = @i) ->
    @new_entry.value.sets = @new_entry.value.sets.slice(0, at)

  merge: (xs...) ->
    if xs?.length > 0
      @tap {}, (m) -> m[k] = v for k, v of x for x in xs

  tap: (o, fn) ->
    fn(o)
    o

export default Base
