import BaseResource from './base_resource'
import Session from '../models/session'

class SessionsResource extends BaseResource
  @model = -> Session

  todays: (success) ->
    url = '/'+@collection()+'/todays.json'
    $.get @path2url(url), @memberClosure(success)

export default SessionsResource
