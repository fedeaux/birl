import BaseResource from './base_resource'
import Progression from '../models/progression'

class ProgressionsResource extends BaseResource
  @model = -> Progression

export default ProgressionsResource
