import BaseResource from './base_resource'
import User from '../models/user'

class UsersResource extends BaseResource
  @model = -> User

export default UsersResource
