import BaseResource from './base_resource'
import Group from '../models/group'

class GroupsResource extends BaseResource
  @model = -> Group

export default GroupsResource
