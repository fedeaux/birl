import BaseResource from './base_resource'
import Entry from '../models/entry'

class EntriesResource extends BaseResource
  @model = -> Entry

export default EntriesResource
