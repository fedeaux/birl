import BaseResource from './base_resource'
import Progression from '../models/progression'

class ProgressionsResource extends BaseResource
  @model = -> Progression

  execute: (id, success) ->
    model = @model()
    $.get @memberUrl(new model(id: id), '/execute'), @memberClosure success

export default ProgressionsResource
