import BaseResource from './base_resource'
import User from '../models/user'

class ProfileResource extends BaseResource
  @model = -> User

  memberUrl: (member, path = '') ->
    @path2url "/profile#{path}.json"

export default ProfileResource
