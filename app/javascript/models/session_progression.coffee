import BaseModel from './base_model'
import Session from './session'
import Progression from './progression'

class SessionProgression extends BaseModel
  @collection = 'session_progressions'
  @member = 'session_progression'
  @class_name = 'SessionProgression'

  @attributes = ->
    {
      id: {}
      session: { type: Session }
      progression: { type: Progression }
      order: {}
    }

export default SessionProgression
