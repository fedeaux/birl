import BaseResource from './base_resource'
import SessionProgression from '../models/session_progression'

class SessionProgressionsResource extends BaseResource
  @model = -> SessionProgression

export default SessionProgressionsResource
