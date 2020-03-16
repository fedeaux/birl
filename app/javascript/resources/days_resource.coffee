import BaseResource from './base_resource'
import Day from '../models/day'

class DaysResource extends BaseResource
  @model = -> Day

export default DaysResource
