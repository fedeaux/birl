import BaseResource from './base_resource'
import Timelog from '../models/timelog'

class TimelogsResource extends BaseResource
  @model = -> Timelog

export default TimelogsResource
