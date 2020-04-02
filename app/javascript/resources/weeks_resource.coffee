import BaseResource from './base_resource'
import Week from '../models/week'

class WeeksResource extends BaseResource
  @model = -> Week

export default WeeksResource
