import BaseResource from './base_resource'
import Context from '../models/context'

class ContextsResource extends BaseResource
  @model = -> Context

export default ContextsResource
