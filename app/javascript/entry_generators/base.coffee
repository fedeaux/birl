import EntryValueSetExecution from '../models/entry_value_set_execution'
import Lister from './lister'

class Base
  constructor: (@params = {}) ->
    @lister = new Lister

  executionFromList: (list, count) ->
    new EntryValueSetExecution type: 'list', values: @lister.list(list, count)

export default Base
