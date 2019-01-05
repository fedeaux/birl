import BaseResource from './base_resource'
import Session from '../models/session'

class SessionsResource extends BaseResource
  @model = -> Session

export default SessionsResource
