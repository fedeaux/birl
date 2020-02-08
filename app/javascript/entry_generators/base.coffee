import EntryValueSetExecution from '../models/entry_value_set_execution'
import Lister from './lister'

class Base
  constructor: (@params = {}) ->
    @lister = new Lister

  executionFromList: (list, count, variations_list = null) ->
    @executionFromArray @lister.list(list, count), (variations_list && @lister.list(variations_list, count))

  executionFromArray: (values, variations = null) ->
    new EntryValueSetExecution type: 'list', values: values, variations: variations

export default Base
