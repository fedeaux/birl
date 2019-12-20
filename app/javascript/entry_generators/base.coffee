import EntryValueSetExecution from '../models/entry_value_set_execution'
import Lister from './lister'

class Base
  constructor: (@params = {}) ->
    @lister = new Lister

  executionFromList: (list, count) ->
    @executionFromArray @lister.list list, count

  executionFromArray: (array) ->
    new EntryValueSetExecution type: 'list', values: array

export default Base
